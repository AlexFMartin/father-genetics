import click
import requests
import sys
import csv
import json
from typing import List


def get_grch37_by_rsids(rsids: List[str]) -> dict:
    """Return a GRCh37 for a given rsID"""

    # adapted from https://grch37.rest.ensembl.org/documentation/info/variation_post
    server = "https://grch37.rest.ensembl.org"
    ext = "/variation/homo_sapiens"
    headers = {"Content-Type": "application/json", "Accept": "application/json"}
    r = requests.post(server + ext, headers=headers, data=json.dumps({"ids": rsids}))

    if not r.ok:
        r.raise_for_status()
        sys.exit()

    answers = r.json()
    grch37s = {}
    for k, v in answers.items():
        try:
            grch37s[k] = extract_grch37(v['mappings'])
        except ValueError:
            raise RuntimeError(f"Cannot find GRCh37 mapping for rsID {k}")

    return grch37s


def extract_grch37(mappings: list) -> str:
    grch37 = None
    for m in mappings:
        if m['assembly_name'] == 'GRCh37':
            grch37 = m
            break
    if not grch37:
        raise ValueError

    return f"{m['strand']}:{m['start']}"


@click.command()
@click.option("--file", help="Input file")
@click.option("--rsid_column", default="rsID", help="RSID column label")
@click.option("--delimiter", default="\t", help="Delimiter for input file")
@click.option("--grch37_column", default="grch37", help="Name for the new GRCh37 column")
@click.option("--output", default=None, help="Output file. Defaults to overwriting input file.")
def do_conversion(file, rsid_column, delimiter, grch37_column, output):
    convert(
        file=file,
        rsid_column=rsid_column,
        delimiter=delimiter,
        grch37_column=grch37_column,
        output=output
    )


def convert(
        file: str,
        rsid_column: [str, int] = "rsID",
        delimiter: str = "\t",
        grch37_column: str = "grch37",
        output: str = None
) -> None:
    with open(file, 'r') as f:
        data = [x for x in csv.DictReader(f, delimiter=delimiter)]
        rsids = [x[rsid_column] for x in data]
        print(f"Looking up {len(rsids)} unique rsIDs")

    grch37s = get_grch37_by_rsids(rsids=rsids)
    # add GRCh37 column to data
    output_data = []
    for x in data:
        try:
            output_data.append({**x, grch37_column: grch37s[x[rsid_column]]})
        except TypeError:
            raise RuntimeError(f"Cannot find GRCh37 entry for rsID {x[rsid_column]}")

    if not output:
        output = file
    with open(output, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=[k for k,_ in output_data[0].items()], delimiter=delimiter)
        writer.writeheader()
        writer.writerows(output_data)
        print(f"Wrote {len(output_data)} rows to {output}")


if __name__ == '__main__':
    convert(
        file="../data/gwas_demo.txt",
        output="../data/gwas_output.txt"
    )

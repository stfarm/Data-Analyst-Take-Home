import psycopg2
from tabulate import tabulate

def run_queries():
    # 1. Read queries from file, split by semicolon
    with open('Closed-ended_questions.sql', 'r', encoding='utf-8') as f:
        file_content = f.read()
        # Split on semicolons, so each chunk is one SQL statement
        queries = file_content.split(';')

    # 2. Connect to PostgreSQL
    conn = psycopg2.connect(
        dbname='assesment',
        user='postgres',
        password='please45',
        host='localhost',
        port=5432
    )
    conn.autocommit = True

    # 3. Open an .md file to store the results
    with open('Closed-ended_questions.md', 'w', encoding='utf-8') as md_file:
        for query in queries:
            q = query.strip()
            # Skip empty lines
            if not q:
                continue

            # Write the query in a code block
            md_file.write(f"## Query\n```sql\n{q}\n```\n\n")

            with conn.cursor() as cur:
                try:
                    # 4. Execute the query
                    cur.execute(q)
                    # If the query returns a result set (e.g. SELECT)
                    if cur.description is not None:
                        # Fetch rows
                        rows = cur.fetchall()
                        # Get column headers
                        colnames = [desc[0] for desc in cur.description]

                        # 5. Convert rows to a Markdown table
                        md_table = tabulate(rows, headers=colnames, tablefmt="github")
                        md_file.write(md_table + "\n\n")
                    else:
                        # For queries like INSERT/UPDATE with no result set
                        md_file.write("No result set returned.\n\n")

                except Exception as e:
                    # Capture any error (e.g. syntax error, invalid column) and write it
                    md_file.write(f"**Error:** {str(e)}\n\n")

            md_file.write("---\n\n")  # Separator after each query's output

    conn.close()


if __name__ == '__main__':
    run_queries()

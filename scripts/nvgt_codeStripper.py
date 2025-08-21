import os
import re

def clean_nvgt_content(content):
    """
    Cleans the content of a .nvgt file according to specific rules.

    Args:
        content (str): The original file content as a string.

    Returns:
        str: The cleaned content as a string.
    """
    # 1. Remove all multi-line comments (/* ... */) first.
    # The `re.DOTALL` flag allows '.' to match newline characters.
    # The `?` after `*` makes the match non-greedy, so it stops at the first `*/`.
    content_no_multiline = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)

    processed_lines = []
    for line in content_no_multiline.splitlines():
        
        # 2. Remove leading/trailing whitespace for easier processing.
        # We will add the stripped line back, effectively removing indentation.
        stripped_line = line.strip()

        # If the line is blank after stripping, ignore it.
        if not stripped_line:
            continue

        # 3. Handle single-line comments (//)
        if stripped_line.startswith('//'):
            # This is a full-line comment. Let's apply the heuristic.
            comment_content = stripped_line[2:].lstrip() # Get text after '//'

            # HEURISTIC: If the comment content starts with a capital letter,
            # we assume it's a descriptive comment and REMOVE the line.
            if comment_content and comment_content[0].isupper():
                # This is a descriptive comment like "// Do something important."
                # We skip it by not adding it to our processed_lines.
                continue
            else:
                # This is likely commented-out code like "// myFunction();"
                # We KEEP the line.
                processed_lines.append(stripped_line)

        elif '//' in stripped_line:
            # This is an inline comment (e.g., `code(); // comment`).
            # We remove the comment part and keep the code part.
            code_part = stripped_line.split('//', 1)[0].rstrip()
            processed_lines.append(code_part)
        
        else:
            # This is a regular line of code with no comments.
            # We keep it, with indentation removed.
            processed_lines.append(stripped_line)

    # 4. Join the cleaned lines back together with newlines.
    return "\n".join(processed_lines)


def process_nvgt_files(root_directory='.'):
    """
    Finds and processes all .nvgt files in a directory tree.

    Args:
        root_directory (str): The starting directory to search from.
                              Defaults to the current directory.
    """
    print(f"[*] Starting search for .nvgt files in '{os.path.abspath(root_directory)}'...")
    
    found_files = 0
    for dirpath, _, filenames in os.walk(root_directory):
        for filename in filenames:
            if filename.endswith('.nvgt') and not filename.endswith('_cleaned.nvgt'):
                found_files += 1
                file_path = os.path.join(dirpath, filename)
                
                print(f"\n[+] Processing: {file_path}")

                try:
                    # Read the original file
                    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                        original_content = f.read()

                    # Get the cleaned content
                    cleaned_content = clean_nvgt_content(original_content)

                    # Create the new filename
                    base, ext = os.path.splitext(file_path)
                    new_file_path = f"{base}_cleaned{ext}"

                    # Write to the new file
                    with open(new_file_path, 'w', encoding='utf-8') as f:
                        f.write(cleaned_content)
                    
                    print(f"[✔] Success! Cleaned file saved as: {new_file_path}")

                except Exception as e:
                    print(f"[!] Error processing {file_path}: {e}")
    
    if found_files == 0:
        print("\n[*] No .nvgt files were found.")
    else:
        print(f"\n[*] Done. Processed {found_files} files.")


if __name__ == "__main__":
    # The script will search in the directory where it is run.
    # If you want to specify a different directory, change the path below.
    # For example: process_nvgt_files('/path/to/your/project')
    process_nvgt_files()

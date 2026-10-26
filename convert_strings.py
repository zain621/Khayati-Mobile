"""
Script to convert all hardcoded Arabic string getters in manager_strings.dart to use tr().
Also generates the JSON translation key-value pairs for ar.json, en.json, and ur.json.
Run: python convert_strings.py
"""
import re

# Read the original file
with open(r'lib\core\resources\manager_strings.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match hardcoded string getters (NOT already using tr())
# Matches: static String get someKey => "value"; or => 'value';
pattern = re.compile(
    r'(  static String get (\w+)\s*=>\s*)(")([^"]+)(")(;)',
)
pattern_single = re.compile(
    r"(  static String get (\w+)\s*=>\s*)(')([^']+)(')(;)",
)

# Multi-line hardcoded string getters
pattern_multi = re.compile(
    r'(  static String get (\w+)\s*=>\s*\n\s*)(")([^"]+)(")(;)',
)

# Collect all keys and Arabic values that are hardcoded
hardcoded = {}

for match in pattern.finditer(content):
    key = match.group(2)
    value = match.group(4)
    hardcoded[key] = value

for match in pattern_single.finditer(content):
    key = match.group(2)
    value = match.group(4)
    hardcoded[key] = value

print(f"Found {len(hardcoded)} hardcoded string getters")
for k, v in list(hardcoded.items())[:10]:
    print(f"  {k}: {v[:50]}")
print("...")

# Now replace all hardcoded getters with tr() calls
def replace_double(m):
    key = m.group(2)
    return f'{m.group(1)}tr(\'{key}\'){m.group(6)}'

def replace_single(m):
    key = m.group(2)
    return f"{m.group(1)}tr('{key}'){m.group(6)}"

new_content = pattern.sub(replace_double, content)
new_content = pattern_single.sub(replace_single, new_content)

# Handle multi-line string getters (with newline before value)
# These look like:
#   static String get key =>
#       "value with multiple words";
pattern_multiline = re.compile(
    r'(  static String get (\w+)\s*=>\n\s+)("([^"]+)")(;)',
)
pattern_multiline_single = re.compile(
    r"(  static String get (\w+)\s*=>\n\s+)('([^']+)')(;)",
)

def replace_multiline_double(m):
    key = m.group(2)
    return f"{m.group(1)}tr('{key}'){m.group(5)}"

def replace_multiline_single(m):
    key = m.group(2)
    return f"{m.group(1)}tr('{key}'){m.group(5)}"

new_content = pattern_multiline.sub(replace_multiline_double, new_content)
new_content = pattern_multiline_single.sub(replace_multiline_single, new_content)

with open(r'lib\core\resources\manager_strings_new.dart', 'w', encoding='utf-8') as f:
    f.write(new_content)

print("\nWrote lib\\core\\resources\\manager_strings_new.dart")
print("Check it carefully, then rename to manager_strings.dart")
print("\nHardcoded keys for translation files:")
for k, v in hardcoded.items():
    print(f'  "{k}": "{v}"')

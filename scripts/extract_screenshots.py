#!/usr/bin/env python3
import os
import sys
import json
import shutil
import glob

def extract(manifest_dir, output_dir, suffix):
    os.makedirs(output_dir, exist_ok=True)
    manifest_file = os.path.join(manifest_dir, "manifest.json")
    handled = False

    if os.path.exists(manifest_file):
        try:
            with open(manifest_file, "r", encoding="utf-8") as f:
                data = json.load(f)

            def find_attachments(obj):
                found = []
                if isinstance(obj, dict):
                    if "exportedFileName" in obj:
                        found.append(obj)
                    for v in obj.values():
                        found.extend(find_attachments(v))
                elif isinstance(obj, list):
                    for v in obj:
                        found.extend(find_attachments(v))
                return found

            attachments = find_attachments(data)
            for att in attachments:
                exp_name = att.get("exportedFileName")
                if not exp_name:
                    continue
                readable = att.get("suggestedHumanReadableName") or att.get("name") or exp_name
                base_name = os.path.splitext(readable)[0]
                # If base_name already contains the suffix, keep it as is; otherwise append
                if suffix and not base_name.endswith(suffix):
                    target_filename = f"{base_name}-{suffix}.png"
                else:
                    target_filename = f"{base_name}.png"

                src_path = os.path.join(manifest_dir, exp_name)
                dst_path = os.path.join(output_dir, target_filename)
                if os.path.exists(src_path):
                    shutil.copy2(src_path, dst_path)
                    print(f"Extracted: {src_path} -> {dst_path}")
                    handled = True
        except Exception as e:
            print(f"Warning: Manifest parsing encountered error: {e}")

    if not handled:
        # Fallback to scanning any PNG files in the directory
        pngs = glob.glob(os.path.join(manifest_dir, "**", "*.png"), recursive=True)
        for i, png in enumerate(sorted(pngs)):
            target_filename = f"01-main-{suffix}.png" if i == 0 else f"screenshot-{i}-{suffix}.png"
            dst_path = os.path.join(output_dir, target_filename)
            shutil.copy2(png, dst_path)
            print(f"Fallback extracted: {png} -> {dst_path}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: extract_screenshots.py <manifest_dir> <output_dir> [suffix]")
        sys.exit(1)
    sfx = sys.argv[3] if len(sys.argv) > 3 else ""
    extract(sys.argv[1], sys.argv[2], sfx)

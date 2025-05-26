---
title: Smart RSpec launcher
type: post
name: smart_rspec_launcher
lang: en
date: 2025-05-27
tags: [rspec]
---

Add this to your **.zshrc** or other shell configuration file to unleash the superpower of **bash** scripting:

```bash
# Running specs

# ber
# ber -c
# ber spec_name -c
# ber spec_name -of
# ber spec_name -f FILE
# ber spec_name -r 2
# ber spec_name -r 2 -c
function ber() {
    local spec_file='spec'
    local repeats=1
    local flag=''
    local invalid_flag=false

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
        -c|--coverage)
            flag='-c'
            shift
            ;;
        -of|--only-failures)
            flag='--only-failures'
            shift
            ;;
        -r|--repeats)
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                repeats="$2"
                shift 2
            else
                echo "Error: -r/--repeats requires a numeric argument"
                return 1
            fi
            ;;
        -f|--file)
            if [[ -n "$2" ]]; then
                spec_file="$2"
                shift 2
            else
                echo "Error: -f requires a filename argument"
                return 1
            fi
            ;;
        *)
            echo "Error: Incorrect flag '$1'"
            echo "Valid flags are:"
            echo "  -c, --coverage       Run with coverage"
            echo "  -of, --only-failures Run only failed examples"
            echo "  -r, --repeats N      Repeat N times"
            echo "  -f FILE              Use specific spec file"
            return 1
            ;;
        esac
    done

    for ((i = 1; i <= repeats; i++)); do
        echo "Run $i/$repeats:"
        be rspec "$spec_file" $flag
    done
}
```

Cheers 🥂!

## CI Waiting

Never write `sleep` + `gh run view` polling loops to wait for CI. Always use the `gh-run-watch` skill which discovers all active runs on the branch and watches them with deduplicated output.
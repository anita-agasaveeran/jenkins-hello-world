#!/bin/sh
mkdir -p build/reports

cat > build/reports/results.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="ExampleTests" tests="3" failures="1" errors="0" skipped="0">
    <testcase classname="ExampleTests" name="testAddition" time="0.001"/>
    <testcase classname="ExampleTests" name="testSubtraction" time="0.001"/>
    <testcase classname="ExampleTests" name="testDivision" time="0.001">
        <failure message="expected 2 but was 3">AssertionError: expected 2 but was 3</failure>
    </testcase>
</testsuite>
EOF

if grep -q "<failure" build/reports/results.xml; then
    echo "Some tests failed"
    exit 1
else
    echo "All tests passed"
    exit 0
fi

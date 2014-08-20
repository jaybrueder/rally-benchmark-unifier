# Rally Benchmark Unifier

Because OpenStack Rally does not yet have an option to run all benchmarks with a single command, I built Rally Reporter.

It combines every single benchmark in the __rally/doc/samples/tasks/scenarios/__ folder into one benchmark file.

## How to use it

Clone this repo next to your __rally__ folder. Your folder structure should look like this

* rally
* rally_benchmark_unifier

Go into __rally_benchmark_unifier__ and run __ruby rally_benchmark_unifier.rb__.
It will put a __all_benchmarks.yaml__ file into the root of your __rally__ folder.

Just navigate into your __rally__ folder and run

```shell
rally -v task all_benchmarks.yaml
```

This will run all benchmarks.

## How to generate a HTML report

After you ran the __all_benchmarks.yaml__ file in the step before, it will return a UUID that looks something like this

```shell
ba04048e-b503-4b24-bd7d-0d81b64325ef
```

Use this UUID in the following command to generate a HTML report from the benchmark results:

```shell
rally task plot2html ba04048e-b503-4b24-bd7d-0d81b64325ef --out reports/all_benchmarks.html
```

## Exclude services from benchmarks

To exclude certain services from the benchmark run the __rally_benchmark_unifier__ like this:

```shell
ruby rally_benchmark_unifier.rb --no-vm --no-tempest --no-sahara --no-heat --no-ceilometer
```
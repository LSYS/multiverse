.PHONY: venv install link-data clean-output freeze help

PYTHON := python3.11
VENV := venv_multiverse
ACTIVATE := . $(VENV)/bin/activate

CITYDATA := /home/lsys/citydata2025

help:
	@echo "Targets:"
	@echo "  venv          Create $(VENV) using $(PYTHON)"
	@echo "  install       pip install -r requirements.txt into venv"
	@echo "  link-data     Symlink dwell-times, ground-truth, census from citydata2025"
	@echo "  clean-output  rm -rf output/*"
	@echo "  freeze        Write current versions to requirements-frozen.txt"

venv:
	$(PYTHON) -m venv $(VENV)
	@echo "Activate with: source $(VENV)/bin/activate"

install:
	$(ACTIVATE) && pip install --upgrade pip
	$(ACTIVATE) && pip install -r requirements.txt

link-data:
	mkdir -p data
	ln -sfn $(CITYDATA)/scripts/06_dwelltimes/output data/dwelltimes
	ln -sfn $(CITYDATA)/scripts/11_validate-home-inference-dwell/input data/validator-inputs
	ln -sfn $(CITYDATA)/scripts/09_validate-home-inference/input data/census
	@echo "Symlinks created in data/"

clean-output:
	rm -rf output/*

freeze:
	$(ACTIVATE) && pip freeze > requirements-frozen.txt

.ONESHELL: data
.PHONY: clean data lint coverage test mlflow

# MLflow
mlflow:
	mlflow server --host $(MLFLOW_HOST) --port ${MLFLOW_PORT} --backend-store-uri $(MLFLOW_TRACKING_URI)

# Cleaning
clean:
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	rm -rf .coverage*

# Styling & linting
lint:
	ruff check *.py src
	ruff format *.py src


# Build dataset
data:
	@cd data/raw
	@kaggle competitions download -c house-prices-advanced-regression-techniques
	@unzip *.zip
	@rm *.zip

# # Create coverage report
# coverage:
# 	@echo ">>> running coverage pytest"
# 	pytest --cov=./src

# # Test
# test: 
# 	ruff check *.py src/*.py

# # Docs
# docs:
# 	cd docs && mkdocs build
# docs-serve:
# 	cd docs && mkdocs serve
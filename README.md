# project_4-home_credit_default_risk

[Notebook exploratory analysis feature engineering ](./Fusilier_Antoine_1_notebook_exploratory_analysis_and_cleaning_and_feature_enginering_022024.ipynb)

[Notebook modelization](./Fusilier_Antoine_2_notebook_modelization_032024.ipynb)

1. Clonez le dépôt :
   ```sh
   git clone https://github.com/lessons-data-ai-engineer/project_4-home_credit_default_risk.git
   cd project_4-home_credit_default_risk.git
   ```
2. Construisez l'image Docker :

    Pour inclure les fichiers `resources` et `exports` :
    ```sh
    docker build --build-arg RESOURCES_URL="https://github.com/lessons-data-ai-engineer/project_4-home_credit_default_risk/raw/main/resources.zip" \
                --build-arg EXPORTS_URL="https://github.com/lessons-data-ai-engineer/project_4-home_credit_default_risk/raw/main/exports.zip" \
                -t project_4-home_credit_default_risk .
    ```

    Pour construire sans inclure les fichiers :
    ```sh
    docker build -t project_4-home_credit_default_risk .
    ```

3. Exécutez le conteneur Docker :
   ```sh
   docker run -p 8888:8888 project_4-home_credit_default_risk
   ```

4. Accédez à Jupyter Notebook via votre navigateur à l'adresse `http://localhost:8888`.

5. Les fichiers sources sont montés dans `/content/resources` et les fichiers générés par les notebooks sont stockés dans `/content/exports`.

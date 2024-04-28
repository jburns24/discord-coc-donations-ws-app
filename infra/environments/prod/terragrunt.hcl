include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../."
}

inputs = {
    location            = "West US 2"
    resource_group_name = "coc-disco-donations-prod"
    app_name            = get_env("APP_NAME", "coc-donations-app-service-prod")
}

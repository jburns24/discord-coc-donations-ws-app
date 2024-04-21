remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "tfstate"
        storage_account_name = "cocdiscodonationstfstate"
        container_name = "tfstate"
    }
}

inputs = {
  location = "West US 2"
  resource_group_name = "coc-disco-donations"
  docker_image_tag = "latest"
}

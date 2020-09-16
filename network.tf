resource "azurerm_virtual_network" "network" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                    = "${var.prefix}-pip"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
  domain_name_label       = var.prefix

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location 			      = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
	name 						  = "AllowSSH"
	priority 					= 100
	direction 					= "Inbound"
	access 						= "Allow"
	protocol 					= "Tcp"
	source_port_range          	= "*"
    destination_port_range     	= "22"
    source_address_prefix      	= "*"
    destination_address_prefix 	= "*"
  }

  security_rule {
	name 						= "AllowHTTP"
	priority					= 200
	direction					= "Inbound"
	access 						= "Allow"
	protocol 					= "Tcp"
	source_port_range          	= "*"
    destination_port_range     	= "80"
    source_address_prefix      	= "Internet"
    destination_address_prefix 	= "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                      = "${var.prefix}-nic"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  # network_security_group_id = azurerm_network_security_group.nsg.id

  ip_configuration {
    name                          = "${var.prefix}-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.5"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Task

* Create a virtual network
* Create a subnet for VM
* Create a vm with a data disk
* Create a shared folder on the data disc
* Configure point to site vpn

## <ins> Creating VPN </ins>

### <ins> Point to site vpn blog on MS learn </ins>
[Azure point to site config](https://learn.microsoft.com/en-us/azure/vpn-gateway/openvpn-azure-ad-tenant)

##  <ins> Linux vpn client config instructions </ins>
[linux vpn connection](https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin?tabs=azure-portal)

* VVPN Gateway 
* VPN Gateway subnet name ,  GatewaySubnet 
* VPN Gateway has to have a public IP address
* Abbreviation for virtual network gatewy is VGW
* VPN-CLient configuration 
   * Teneant &rarr; Azure active directory login path 
     * login into azure admin portal
     * click on entera id 
     * Copy teneant_id
   * Audience &rarr; Application id
   * Issuer &rarr; stc id
 * note the certificate for the VPN client is **DigitCert Global** Root CA
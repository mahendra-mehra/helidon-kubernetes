output "vcn_id" {
  description = "id of vcn where oke is created. use this vcn id to add additional resources"
  value       = module.k3s.vcn_id
}
output "ssh_to_server" {
  description = "convenient command to ssh to the server host"
  value       = module.k3s.ssh_to_server
}
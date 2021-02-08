output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
output "external_ip_address_app2" {
  value = yandex_compute_instance.app2.network_interface.0.nat_ip_address
}

output "lb_ip_address" {
  value = element(element([
    for listener in yandex_lb_network_load_balancer.app.listener :
    listener.external_address_spec.*.address
    if listener.name == "reddit-app-listener"
  ], 0), 0)
}

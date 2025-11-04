#include <pulsar/c/client.h>

void __real_pulsar_client_configuration_set_logger_t(
    pulsar_client_configuration_t *conf, pulsar_logger_t logger);

// We're using ld's --wrap feature here to translate between HSC and the
// library as HSC only allows structs as arguments as pointers while the
// library expects a struct (not a pointer to one).
void __wrap_pulsar_client_configuration_set_logger_t(
    pulsar_client_configuration_t *conf, pulsar_logger_t *logger) {
  __real_pulsar_client_configuration_set_logger_t(conf, *logger);
}

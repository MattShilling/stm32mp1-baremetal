add_subdirectory(codec)
add_subdirectory(i2c)
add_subdirectory(sai)
add_subdirectory(interrupt)
add_subdirectory(pin)

add_library(drivers-cycle-counter cycle_counter.cc)

# add_library(hal-handlers hal_handlers.cc)


# add_library(irq-ctrl irq_ctrl.c)

# add_library(irq-handler irq_handler.cc)

# add_library(pin pin.cc)


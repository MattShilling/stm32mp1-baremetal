add_executable(main main.cc mmu_ca7.c)

target_link_libraries(main
    DaisySP
    drivers-cycle-counter
    drivers-codec-CS43L51
    drivers-sai-tdm
    math-tables)
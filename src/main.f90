program DO3SE_main
    use module_demo
    implicit none
    character(len=256) :: arg1
    integer :: arg2
    print *, "hello world"
    call get_command_argument(1, arg1)
    print * , arg1

    call ra(1, arg2)
    print *, arg2

end program DO3SE_main

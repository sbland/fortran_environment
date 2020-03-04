program DO3SE_main
    implicit none
    character(len=256) :: arg1

    print *, "hello world"
    call get_command_argument(1, arg1)
    print * , arg1
  
end program DO3SE_main
  
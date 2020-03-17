module module_demo
    ! use module_demo_external

    implicit none

contains
    subroutine ra(arg1,  arg2)
        implicit none
        integer,intent(in) :: arg1
        integer,intent(out) ::  arg2
        arg2 = arg1 + 1
        ! call rab(arg1, arg2)
    end subroutine ra
end module module_demo

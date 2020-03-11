module module_demo
    implicit none

contains
    subroutine ra(arg1,  arg2)
        implicit none
        integer,intent(in) :: arg1
        integer,intent(out) ::  arg2
        arg2 = arg1 + 1
    end subroutine ra
end module module_demo

module module_demo
    use module_demo_external

    implicit none

contains
    subroutine ra(arg1,  arg2)
        implicit none
        integer,intent(in) :: arg1
        integer,intent(out) ::  arg2
        call rab(arg1, arg2)
    end subroutine ra
end module module_demo

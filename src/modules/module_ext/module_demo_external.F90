module module_demo_external
    implicit none

    private

    public :: rab
contains
    pure subroutine rab(arg1,  arg2)
        implicit none
        integer,intent(in) :: arg1
        integer,intent(out) ::  arg2
        arg2 = arg1 + 10
    end subroutine rab
end module module_demo_external

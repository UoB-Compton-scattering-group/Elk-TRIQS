
! Copyright (C) 2018 J. K. Dewhurst, S. Sharma and E. K. U. Gross.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

subroutine splintp(n,x,f,g)
implicit none
! arguments
integer, intent(in) :: n
real(8), intent(in) :: x(n),f(n)
real(8), intent(out) :: g(n)
! local variables
integer i
real(8) x0,x1,x2,x3,y0,y1,y2,y3
real(8) t0,t1,t2,t3,t4,t5,t6,t7
if (n.lt.5) then
  write(*,*)
  write(*,'("Error(splint): n < 5 : ",I8)') n
  write(*,*)
  stop
end if
! fit piecewise cubic spline to data and store the partial integrals
x0=x(1)
x1=x(2)-x0; x2=x(3)-x0; x3=x(4)-x0
t4=x1-x2; t5=x1-x3; t6=x2-x3
y0=f(1)
y1=f(2)-y0; y2=f(3)-y0; y3=f(4)-y0
t1=x1*x2*y3; t2=x2*x3*y1; t3=x1*x3
t0=0.5d0/(x2*t3*t4*t5*t6)
t3=t3*y2
t7=t1*t4+t2*t6-t3*t5
t4=x1**2; t5=x2**2; t6=x3**2
y1=t3*t6-t1*t5; y3=t2*t5-t3*t4; y2=t1*t4-t2*t6
t1=x1*y1+x2*y2+x3*y3
t2=y1+y2+y3
g(1)=0.d0
g(2)=x1*(y0+t0*x1*(t1+x1*(0.5d0*t7*x1-0.6666666666666666667d0*t2)))
g(3)=x2*(y0+t0*x2*(t1+x2*(0.5d0*t7*x2-0.6666666666666666667d0*t2)))
do i=3,n-3
  x0=x(i)
  x1=x(i-1)-x0; x2=x(i+1)-x0; x3=x(i+2)-x0
  t4=x1-x2; t5=x1-x3; t6=x2-x3; t3=x1*x3
  y0=f(i)
  y1=f(i-1)-y0; y2=f(i+1)-y0; y3=f(i+2)-y0
  t1=x1*x2*y3; t2=x2*x3*y1
  t0=0.5d0/(t3*t4*t5*t6)
  t3=t3*y2
  t7=t1*t4+t2*t6-t3*t5
  t4=x1**2; t5=x2**2; t6=x3**2
  y1=t3*t6-t1*t5; y2=t1*t4-t2*t6; y3=t2*t5-t3*t4
  t1=x1*y1+x2*y2+x3*y3
  t2=y1+y2+y3
  g(i+1)=x2*(y0+t0*(t1+x2*(0.5d0*t7*x2-0.6666666666666666667d0*t2)))
end do
x0=x(n-2)
x1=x(n-3)-x0; x2=x(n-1)-x0; x3=x(n)-x0
t4=x1-x2; t5=x1-x3; t6=x2-x3
y0=f(n-2)
y1=f(n-3)-y0; y2=f(n-1)-y0; y3=f(n)-y0
t1=x1*x2*y3; t2=x2*x3*y1; t3=x1*x3
t0=0.5d0/(x2*t3*t4*t5*t6)
t3=t3*y2
t7=t1*t4+t2*t6-t3*t5
t4=x1**2; t5=x2**2; t6=x3**2
y1=t3*t6-t1*t5; y2=t1*t4-t2*t6; y3=t2*t5-t3*t4
t1=x1*y1+x2*y2+x3*y3
t2=y1+y2+y3
g(n-1)=x2*(y0+t0*x2*(t1+x2*(0.5d0*t7*x2-0.6666666666666666667d0*t2)))
g(n)=x3*(y0+t0*x3*(t1+x3*(0.5d0*t7*x3-0.6666666666666666667d0*t2)))
do i=4,n-1
  g(i)=g(i)+g(i-1)
end do
g(n)=g(n)+g(n-2)
return
end subroutine


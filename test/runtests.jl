using Test
using DifferentialAlgebra

@test 1+1==2

@testset "Constructors" begin
    a = @test_nowarn DANumber(1,1,(1.0,0.0))
    @test a isa Number
    b = @test_nowarn DANumber(1,1,(1.0,))
    @test b isa Number
    @test b == a
    c = @test_nowarn DANumber(1,1,(1.0,0.0,1.0,1.0))
    @test c isa Number
    @test c == b
end

@testset "Addition" begin
    a = DANumber(1,1,(1.0,2.0))
    b = DANumber(1,1,(2.0,3.0))
    c = DANumber(1,1,(3.0,5.0))
    @test a + b == c

    a = DANumber(2,1,(1.0,2.0,5.0))
    b = DANumber(1,1,(2.0,3.0))
    c = DANumber(2,1,(3.0,5.0,5.0))
    @test a + b == c

    a = DANumber(1,1,(1.0,2.0))
    b = DANumber(2,1,(2.0,3.0,5.0))
    c = DANumber(2,1,(3.0,5.0,5.0))
    @test a + b == c
end

@testset "Subtraction" begin
    a = DANumber(1,1,(1.0,2.0))
    b = DANumber(1,1,(2.0,3.0))
    c = DANumber(1,1,(-1.0,-1.0))
    @test a - b == c

    a = DANumber(2,1,(1.0,2.0,5.0))
    b = DANumber(1,1,(2.0,3.0))
    c = DANumber(2,1,(-1.0,-1.0,5.0))
    @test a - b == c

    a = DANumber(1,1,(1.0,2.0))
    b = DANumber(2,1,(2.0,3.0,5.0))
    c = DANumber(2,1,(-1.0,-1.0,-5.0))
    @test a - b == c
end

@testset "Scalar multiplication" begin
    a = 2
    b = DANumber(1,1,(1.0,2.5))
    c = DANumber(1,1,(2.0,5.0))
    @test a*b == c
    @test b*a == c
end

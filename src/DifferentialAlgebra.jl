module DifferentialAlgebra

    export DANumber

    struct DANumber{T,N} <: Number
        order::Integer
        dimension::Integer
        danumber::NTuple{N,T}
        function DANumber{T,N}(o,d,da) where {T,N}
            if o < 0
                throw(ArgumentError("Order of DANumber must be non-negative."))
            elseif d < 1
                throw(ArgumentError("Dimension of DANumber must be positive."))
            else
                N2 = binomial(o+d,d)
                if N == N2
                    return new(o,d,da)
                else
                    throw(ArgumentError("Order and dimension must match ntuple."))
                end
            end
        end
    end

    function DANumber(o,d,da)
        T = typeof(first(da))
        l = length(da)
        lnew = binomial(o+d,d)
        danew = Tuple((i > l ? zero(T) : da[i] for i = 1:lnew))
        return DANumber{T,lnew}(o,d,danew)
    end

    ord(a::DANumber) = a.order

    dim(a::DANumber) = a.dimension

    tuple(a::DANumber) = a.danumber

    import Base.+

    +(a::Real,b::DANumber) = DANumber(ord(a),dim(a),Tuple(())

    function +(a::DANumber,b::DANumber)
        if dim(a) == dim(b)
            oa, ob = ord(a), ord(b)
            daa, dab = tuple(a), tuple(b)
            na, nb = length(daa), length(dab)
            T = promote_type(typeof(first(daa)),typeof(first(dab)))
            d = dim(a)
            if oa > ob
                return DANumber(oa,d,Tuple((daa[i] + (i > nb ? zero(T) : dab[i]) for i = 1:na)))
            else
                return DANumber(ob,d,Tuple((dab[i] + (i > na ? zero(T) : daa[i]) for i = 1:nb)))
            end
        else
            throw(MethodError("Cannot add DANumbers of different dimensions."))
        end
    end

    function +(a::DANumber{T,N},b::DANumber{S,N}) where {T,S,N}
        if dim(a) == dim(b)
            daa, dab = tuple(a), tuple(b)
            o = ord(a)
            d = dim(a)
            return DANumber(o,d,Tuple((daa[i] + dab[i] for i = 1:N)))
        else
            throw(MethodError("Cannot add DANumbers of different dimensions."))
        end
    end

    import Base.-

    function -(a::DANumber,b::DANumber)
        if dim(a) == dim(b)
            oa, ob = ord(a), ord(b)
            daa, dab = tuple(a), tuple(b)
            na, nb = length(daa), length(dab)
            T = promote_type(typeof(first(daa)),typeof(first(dab)))
            d = dim(a)
            if oa > ob
                return DANumber(oa,d,Tuple((daa[i] - (i > nb ? zero(T) : dab[i]) for i = 1:na)))
            else
                return DANumber(ob,d,Tuple(((i > na ? zero(T) : daa[i]) - dab[i] for i = 1:nb)))
            end
        else
            throw(MethodError("Cannot subtract DANumbers of different dimensions."))
        end
    end

    function -(a::DANumber{T,N},b::DANumber{S,N}) where {T,S,N}
        if dim(a) == dim(b)
            daa, dab = tuple(a), tuple(b)
            o = ord(a)
            d = dim(a)
            return DANumber(o,d,Tuple((daa[i] - dab[i] for i = 1:N)))
        else
            throw(MethodError("Cannot subtract DANumbers of different dimensions."))
        end
    end

    import Base.*

    *(a::Real,b::DANumber) = DANumber(ord(b),dim(b),Tuple((a*bval for bval in tuple(b))))
    *(b::DANumber,a::Real) = a*b

    import Base.<

    <(a)
end # End of module

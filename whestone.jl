using Printf

# ========== Subroutines ==========

function sub1!(e, t1, t3)
    for _ = 1:6
        e[1] = (e[1] + e[2] + e[3] - e[4]) * t1
        e[2] = (e[1] + e[2] - e[3] + e[4]) * t1
        e[3] = (e[1] - e[2] + e[3] + e[4]) * t1
        e[4] = (-e[1] + e[2] + e[3] + e[4]) / t3
    end
end

function sub2!(x, y, z, t1, t3)
    x1 = (x + y) * t1
    y1 = (x1 + y) * t1
    z  = (x1 + y1) / t3
    return x, y, z
end

function sub3!(e1, j, k, l)
    tmp = e1[j]
    e1[j] = e1[k]
    e1[k] = e1[l]
    e1[l] = tmp
end

function secndsmy()
    return time()
end

# ========== Main Benchmark Function ==========

function whetstone()
    print("Number of inner loops (suggest more than 3):  ")
    inner = parse(Int, readline())
    print("Number of outer loops (suggest more than 1):  ")
    outer = parse(Int, readline())

    max_pass = 2
    npass = 0

    # Declare before loop so they're available later
    dif_time = 0.0
    dif_save = 0.0
    whet_save = 0.0
    kilowhet = 0.0

    while npass < max_pass
        @printf(" Pass #%02d: %10d outer loop(s), %10d inner loop(s)\n", npass + 1, outer, inner)
        println("="^60)

        kount = 0
        begin_time = secndsmy()

        while kount < outer
            t1 = 0.499975
            t2 = 0.50025
            t3 = 2.0

            isave = inner
            n2, n3, n4 = 12*inner, 14*inner, 345*inner
            n6, n7, n8 = 210*inner, 32*inner, 899*inner
            n9, n11    = 616*inner, 93*inner

            e1 = [1.0, -1.0, -1.0, -1.0]

            for _ = 1:n2
                e1[1] = (e1[1] + e1[2] + e1[3] - e1[4]) * t1
                e1[2] = (e1[1] + e1[2] - e1[3] + e1[4]) * t1
                e1[3] = (e1[1] - e1[2] + e1[3] + e1[4]) * t1
                e1[4] = (-e1[1] + e1[2] + e1[3] + e1[4]) * t1
            end

            for _ = 1:n3
                sub1!(e1, t1, t3)
            end

            j = 1
            for _ = 1:n4
                if j == 1
                    j = 2
                else
                    j = 3
                end

                if j == 2
                    j = 1
                else
                    j = 0
                end

                if j == 1
                    j = 1
                else
                    j = 0
                end
            end

            j, k, l = 1, 2, 3
            for _ = 1:n6
                j = j * (k - j) * (l - k)
                k = l * k - (l - j) * k
                l = (l - k) * (k + j)
                e1[l] = j + k + l
                e1[k] = j * k * l
            end

            x = 0.5
            y = 0.5
            for _ = 1:n7
                x = t1 * atan(t3 * sin(x) * cos(x) /
                    (cos(x + y) + cos(x - y) - 1.0))
                y = t1 * atan(t3 * sin(y) * cos(y) /
                    (cos(x + y) + cos(x - y) - 1.0))
            end

            x, y, z = 1.0, 1.0, 1.0
            for _ = 1:n8
                x, y, z = sub2!(x, y, z, t1, t3)
            end

            j, k, l = 1, 2, 3
            e1 = [1.0, 2.0, 3.0, e1[4]]
            for _ = 1:n9
                sub3!(e1, j, k, l)
            end

            x = 0.75
            for _ = 1:n11
                x = sqrt(exp(log(x) / t2))
            end

            inner = isave
            kount += 1
        end

        end_time = secndsmy()
        dif_time = end_time - begin_time
        kilowhet = 100.0 * (outer * inner) / dif_time

        @printf(" Elapsed time = %12.2f seconds\n", dif_time)
        @printf(" Whetstones   = %12.2f double-precision kilowhets/second\n", kilowhet)

        if npass == 0
            dif_save = dif_time
            whet_save = kilowhet
            inner *= max_pass
        end

        npass += 1
    end

    error = dif_time - (dif_save * max_pass)
    whet_err = whet_save - kilowhet
    percent_err = whet_err * 100.0 / kilowhet

    println("\n", "="^60)
    @printf(" Time error   = %12.2f seconds\n", error)
    @printf(" Whet error   = %12.2f kwhets/sec\n", whet_err)
    @printf(" %%    error   = %12.2f %% whet error\n", percent_err)

    if dif_time < 10.0
        println("TIME is less than 10 seconds -- suggest larger inner loop")
    end
end

# ========= Entry Point =========
whetstone()

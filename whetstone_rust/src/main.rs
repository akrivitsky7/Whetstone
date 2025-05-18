// Rust Whetstone  Benchmark
// (c) Copyright 2002 - 2025 Anatoly S. Krivitsky, Ph.D.
// All rights reserved.
//
// Conditional permission for free use of the code:
// As long as the above copyright notice is included,
// the author grants permission to any person or organization
// to use, distribute, and publish this code for free.
//
// Questions and comments may be directed to:
//   akrivitsky@yahoo.com
//   akrivitsky@gmail.com
//
// Disclaimer of Liability:
// The user assumes all responsibility and risk for the use of this code "as is".
// There is no warranty of any kind associated with this code.
//
// Under no circumstances, including negligence, shall the author be liable for
// any DIRECT, INDIRECT, INCIDENTAL, SPECIAL, or CONSEQUENTIAL DAMAGES,
// or LOST PROFITS that result from the use or inability to use the code.
//
// The author shall not be liable for any such damages, including but not limited to,
// reliance by any person on any information obtained from the code.
// ============================================================================
use std::time::Instant;

fn main() {
    let mut npass = 0;
    let max_pass = 2;

    println!("Number of inner loops (suggest more than 3):");
    let inner: usize = read_number();
    println!("Number of outer loops (suggest more than 1):");
    let outer: usize = read_number();

    let mut dif_save: f64 = 0.0;
    let mut whet_save: f64 = 0.0;

    while npass < max_pass {
        println!(
            "Pass #{:>2}: {:>10} outer loop(s), {:>10} inner loop(s)",
            npass + 1,
            outer,
            inner
        );
        println!("{}", "=".repeat(60));

        let mut kount = 0;
        let begin_time = Instant::now();

        while kount < outer {
            let t1: f64 = 0.499975;
            let t2: f64 = 0.50025;
            let t3: f64 = 2.0;

            let n2 = 12 * inner;
            let n3 = 14 * inner;
            let n4 = 345 * inner;
            let n6 = 210 * inner;
            let n7 = 32 * inner;
            let n8 = 899 * inner;
            let n9 = 616 * inner;
            let n11 = 93 * inner;

            let mut e1: [f64; 4] = [1.0, -1.0, -1.0, -1.0];

            for _ in 0..n2 {
                e1[0] = (e1[0] + e1[1] + e1[2] - e1[3]) * t1;
                e1[1] = (e1[0] + e1[1] - e1[2] + e1[3]) * t1;
                e1[2] = (e1[0] - e1[1] + e1[2] + e1[3]) * t1;
                e1[3] = (-e1[0] + e1[1] + e1[2] + e1[3]) * t1;
            }

            for _ in 0..n3 {
                sub1(&mut e1, t1, t3);
            }

            let mut j: i32 = 1;
            for _ in 0..n4 {
                j = match j {
                    1 => 2,
                    2 => 3,
                    _ => 1,
                };
            }

            let mut j: i32 = 1;
            let mut k: i32 = 2;
            let mut l: i32 = 3;
            for _ in 0..n6 {
                j = j.wrapping_mul(k - j).wrapping_mul(l - k);
                k = l.wrapping_mul(k) - (l - j).wrapping_mul(k);
                l = (l - k).wrapping_mul(k + j);
                e1[(l.saturating_sub(1) as usize) % 4] = (j + k + l) as f64;
                e1[(k.saturating_sub(1) as usize) % 4] = (j * k * l) as f64;
            }

            let mut x: f64 = 0.5;
            let mut y: f64 = 0.5;
            for _ in 0..n7 {
                x = t1
                    * ((t3 * x.sin() * x.cos())
                        / ((x + y).cos() + (x - y).cos() - 1.0))
                    .atan();
                y = t1
                    * ((t3 * y.sin() * y.cos())
                        / ((x + y).cos() + (x - y).cos() - 1.0))
                    .atan();
            }

            let mut x: f64 = 1.0;
            let mut y: f64 = 1.0;
            let mut z: f64 = 1.0;
            for _ in 0..n8 {
                sub2(&mut x, &mut y, &mut z, t1, t3);
            }

            let j: i32 = 0;
            let k: i32 = 1;
            let l: i32 = 2;
            e1 = [1.0, 2.0, 3.0, e1[3]];
            for _ in 0..n9 {
                sub3(&mut e1, j, k, l);
            }

            let mut x: f64 = 0.75;
            for _ in 0..n11 {
                x = (x.ln() / t2).exp().sqrt();
            }

            kount += 1;
        }

        let dif_time = begin_time.elapsed().as_secs_f64();
        let kilowhet = 100.0 * (outer * inner) as f64 / dif_time;
        println!(
            "Elapsed time = {:12.2e} seconds, Whetstones = {:12.2e} kilowhets/sec",
            dif_time, kilowhet
        );

        if npass == 0 {
            dif_save = dif_time;
            whet_save = kilowhet;
        }

        npass += 1;
    }

    let error = dif_save * max_pass as f64 - dif_save;
    let whet_err = whet_save - (100.0 * (inner * outer) as f64 / dif_save);
    let percent_err = whet_err * 100.0 / (100.0 * (inner * outer) as f64 / dif_save);
    println!("{}", "=".repeat(60));
    println!(
        "Time error = {:12.2e}, Whet error = {:12.2e}, % error = {:12.2e}",
        error, whet_err, percent_err
    );
}

fn sub1(e: &mut [f64; 4], t1: f64, t3: f64) {
    for _ in 0..6 {
        e[0] = (e[0] + e[1] + e[2] - e[3]) * t1;
        e[1] = (e[0] + e[1] - e[2] + e[3]) * t1;
        e[2] = (e[0] - e[1] + e[2] + e[3]) * t1;
        e[3] = (-e[0] + e[1] + e[2] + e[3]) / t3;
    }
}

fn sub2(x: &mut f64, y: &mut f64, z: &mut f64, t1: f64, t3: f64) {
    let mut x1 = *x;
    let mut y1 = *y;
    x1 = (x1 + y1) * t1;
    y1 = (x1 + y1) * t1;
    *z = (x1 + y1) / t3;
}

fn sub3(e1: &mut [f64; 4], j: i32, k: i32, l: i32) {
    let j = j as usize % 4;
    let k = k as usize % 4;
    let l = l as usize % 4;

    let temp = e1[j];
    e1[j] = e1[k];
    e1[k] = e1[l];
    e1[l] = temp;
}

fn read_number() -> usize {
    use std::io::{stdin, stdout, Write};
    let mut input = String::new();
    let _ = stdout().flush();
    stdin().read_line(&mut input).unwrap();
    input.trim().parse().unwrap_or(1)
}

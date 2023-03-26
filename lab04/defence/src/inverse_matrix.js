function vecMake(n, val)
{
  let result = [];
  for (let i = 0; i < n; ++i) {
    result[i] = val;
  }
  return result;
}

function vecInit(s)
{
  let vals = s.split(',');
  let result = [];
  for (let i = 0; i < vals.length; ++i) {
    result[i] = parseFloat(vals[i]);
  }
  return result;
}

function matMake(rows, cols, val)
{
  let result = [];
  for (let i = 0; i < rows; ++i) {
    result[i] = [];
    for (let j = 0; j < cols; ++j) {
      result[i][j] = val;
    }
  }
  return result;
}

function matInit(rows, cols, s)
{
  // ex: let m = matInit(2, 3, "1,2,3, 4,5,6");
  let result = matMake(rows, cols, 0.0);
  let vals = s.split(',');
  let k = 0;
  for (let i = 0; i < rows; ++i) {
    for (let j = 0; j < cols; ++j) {
      result[i][j] = parseFloat(vals[k++]);
    }
  }
  return result;
}

function vecShow(v, dec, wid)
{
  for (let i = 0; i < v.length; ++i) {
    if (v[i] >= 0.0) {
      let x = v[i];
      if (x < 1.0e-5) x = 0.0;  // avoid -0.00 display
      process.stdout.write(" ");  // (no auto newline)
    }
    process.stdout.write(x.toFixed(dec).padStart(wid, ' '));
  }
  process.stdout.write("\n");
}

function matShow(m, dec, wid)
{
  let rows = m.length;
  let cols = m[0].length;
  for (let i = 0; i < rows; ++i) {
    for (let j = 0; j < cols; ++j) {
      let x = m[i][j];
      if (x < 1.0e-5) x = 0.0;
      process.stdout.write(x.toFixed(dec).padStart(wid, ' '));
      process.stdout.write("  ");
    }
    process.stdout.write("\n");
  }
}

function matProduct(ma, mb)
{
  let aRows = ma.length;
  let aCols = ma[0].length;
  let bRows = mb.length;
  let bCols = mb[0].length;
  if (aCols != bRows) {
    throw "Non-conformable matrices";
  }

  let result = matMake(aRows, bCols, 0.0);

  for (let i = 0; i < aRows; ++i) { // each row of A
    for (let j = 0; j < bCols; ++j) { // each col of B
      for (let k = 0; k < aCols; ++k) { // could use bRows
        result[i][j] += ma[i][k] * mb[k][j];
      }
    }
  }

  return result;
}

function matInverse(m)
{
  // assumes determinant is not 0
  // that is, the matrix does have an inverse
  let n = m.length;
  let result = matMake(n, n, 0.0); // make a copy
  for (let i = 0; i < n; ++i) {
    for (let j = 0; j < n; ++j) {
      result[i][j] = m[i][j];
    }
  }

  let lum = matMake(n, n, 0.0); // combined lower & upper
  let perm = vecMake(n, 0.0);  // out parameter
  matDecompose(m, lum, perm);  // ignore return

  let b = vecMake(n, 0.0);
  for (let i = 0; i < n; ++i) {
    for (let j = 0; j < n; ++j) {
      if (i == perm[j])
        b[j] = 1.0;
      else
        b[j] = 0.0;
    }

  let x = reduce(lum, b); //
    for (let j = 0; j < n; ++j)
      result[j][i] = x[j];
  }
  return result;
}

function matDeterminant(m)
{
  let n = m.length;
  let lum = matMake(n, n, 0.0);
  let perm = vecMake(n, 0.0);
  let result = matDecompose(m, lum, perm);  // -1 or +1
  for (let i = 0; i < n; ++i)
    result *= lum[i][i];
  return result;
}
function matMake(rows, cols, val)
{
  let result = [];
  for (let i = 0; i < rows; ++i) {
    result[i] = [];
    for (let j = 0; j < cols; ++j) {
      result[i][j] = val;
    }
  }
  return result;
}

function matDecompose(m, lum, perm)
{
  // Crout's LU decomposition for matrix determinant and inverse
  // stores combined lower & upper in lum[][]
  // stores row permuations into perm[]
  // returns +1 or -1 according to even or odd perms
  // lower gets dummymatProduct 1.0s on diagonal (0.0s above)
  // upper gets lum values on diagonal (0.0s below)

  let toggle = +1; // even (+1) or odd (-1) row permutatuions
  let n = m.length;

  // make a copy of m[][] into result lum[][]
  //lum = matMake(n, n, 0.0);
  for (let i = 0; i < n; ++i) {
    for (let j = 0; j < n; ++j) {
      lum[i][j] = m[i][j];
    }
  }

  // make perm[]
  //perm = vecMake(n, 0.0);
  for (let i = 0; i < n; ++i)
    perm[i] = i;

  for (let j = 0; j < n - 1; ++j) {  // note n-1
    let max = Math.abs(lum[j][j]);
    let piv = j;

    for (let i = j + 1; i < n; ++i) {  // pivot index
      let xij = Math.abs(lum[i][j]);
      if (xij > max) {
        max = xij;
        piv = i;
      }
    } // i

    if (piv != j) {
      let tmp = lum[piv];  // swap rows j, piv
      lum[piv] = lum[j];
      lum[j] = tmp;

      let t = perm[piv];  // swap perm elements
      perm[piv] = perm[j];
      perm[j] = t;

      toggle = -toggle;
    }

    let xjj = lum[j][j];
    if (xjj != 0.0) {  // TODO: fix bad compare here
      for (let i = j + 1; i < n; ++i) {
        let xij = lum[i][j] / xjj;
        lum[i][j] = xij;
        for (let k = j + 1; k < n; ++k) {
          lum[i][k] -= xij * lum[j][k];
          console.log();
        }
      }
    }

  } // j

  return toggle;  // for determinant
} // matDecompose

function reduce(lum, b) // helper
{
  let n = lum.length;
  let x = vecMake(n, 0.0);
  for (let i = 0; i < n; ++i) {
    x[i] = b[i];
  }

  for (let i = 1; i < n; ++i) {
    let sum = x[i];
    for (let j = 0; j < i; ++j) {
      sum -= lum[i][j] * x[j];
      console.log(sum);
    }
    x[i] = sum;
  }

  x[n - 1] /= lum[n - 1][n - 1];
  for (let i = n - 2; i >= 0; --i) {
    let sum = x[i];
    for (let j = i + 1; j < n; ++j) {
      sum -= lum[i][j] * x[j];
      console.log(sum);
    }
    x[i] = sum / lum[i][i];
  }

  return x;
} // reduce

function main()
{
  process.stdout.write("\033[0m");  // reset font color
  process.stdout.write("\x1b[1m" + "\x1b[37m");  // bright white
  console.log("\nBegin matrix inversion using JavaScript demo ");

//   let m = matInit(4, 4, "3,7,2,5," +
//                         "4,0,1,1," +
//                         "1,6,3,0," +
//                         "2,8,4,3 " );
  // let m = [[3, 7, 2, 5], [4, 0, 1, 1], [1, 6, 3, 0], [2, 8, 4, 3]];
  // let m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
  let m = [[1, 2], [3, 4]];

  console.log("\nOriginal matrix m is: ");
  matShow(m, 1, 5);

  let d = matDeterminant(m);
  console.log("\nDeterminant of m = ");
  console.log(d);

  let inv = matInverse(m);
  console.log("\nInverse of m is: ");
  matShow(inv, 4, 8);

  let check = matProduct(m, inv);
  console.log("\nProduct of m * inv is: ");
  matShow(check, 2, 7);

  process.stdout.write("\033[0m");  // reset
  console.log("\nEnd demo");
}

main();
// Note this code was heavily borrowed from the javascript npm package gamma
// All credits for algorithms / implementation go to those authors

import 'dart:math';

const g = 7;
const p = [
  0.99999999999980993,
  676.5203681218851,
  -1259.1392167224028,
  771.32342877765313,
  -176.61502916214059,
  12.507343278686905,
  -0.13857109526572012,
  9.9843695780195716e-6,
  1.5056327351493116e-7
];

const gLN = 607 / 128;
const pLN = [
  0.99999999999999709182,
  57.156235665862923517,
  -59.597960355475491248,
  14.136097974741747174,
  -0.49191381609762019978,
  0.33994649984811888699e-4,
  0.46523628927048575665e-4,
  -0.98374475304879564677e-4,
  0.15808870322491248884e-3,
  -0.21026444172410488319e-3,
  0.21743961811521264320e-3,
  -0.16431810653676389022e-3,
  0.84418223983852743293e-4,
  -0.26190838401581408670e-4,
  0.36899182659531622704e-5
];

/// Spouge approximation (suitable for large arguments)
double lngamma(double z) {
  if (z < 0) {
    return double.nan;
  }
  var x = pLN[0];
  for (var i = pLN.length - 1; i > 0; --i) {
    x += pLN[i] / (z + i);
  }
  final t = z + gLN + 0.5;
  return .5 * log(2 * pi) + (z + .5) * log(t) - t + log(x) - log(z);
}

/// Gamma function
double gamma(double z) {
  var z_ = z;
  if (z_ < 0.5) {
    return pi / (sin(pi * z_) * gamma(1 - z_));
  } else if (z_ > 100) {
    return exp(lngamma(z_));
  } else {
    z_ -= 1;
    var x = p[0];
    for (var i = 1; i < g + 2; i++) {
      x += p[i] / (z_ + i);
    }
    final t = z_ + g + 0.5;

    return sqrt(2 * pi) * pow(t, z_ + 0.5) * exp(-t) * x;
  }
}

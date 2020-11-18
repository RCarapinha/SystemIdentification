# SystemIdentification

Work done in System Identification of 5th year of Masters.

## Work 1

Determination of Functional Parameters of a Transistor

In this work we intend to perform several tests on a transistor, through the “TransistorTest_IS” function which allows us to polarize the transistor with a voltage 𝑉𝐷𝑠 (between 25V and 35V)
and a voltage 𝑉𝐺𝑠 (between -1.2V and -1.4V) and apply voltages of 𝑣𝑖(𝑡) and 𝑣𝑜(𝑡). With these tests we intend to
calculate the linear model that simulates the behavior for the small signal of a transistor.

The specific objectives of the assignment are as follows:
* Determination of the 4 coefficients shown in Fig.2, namely, 𝐶𝐺𝑠, 𝑟𝑜, 𝐶𝐷𝑠 and 𝑔𝑚.
* Validation of the obtained model and comparation with the test function.

## Work 2

A nonlinear dynamic system, of input 𝑥(𝑡) and output 𝑦(𝑡), is measured through the MATLAB function:

𝑦 = 𝑺𝒚𝒔𝒕𝒆𝒎𝑾𝑨𝟎𝟐(𝑥,𝑡, 𝑁𝑢𝑚𝑀𝑒𝑐)

The objective of this work is to design and generate a set of graphics which can be used to evaluate the behavior of this system (i.e., to build a non-parametric model based on graphical representations).

## Work 3

Nonlinear Optimization Algorithms

Optimization methods are very important tools when it comes to identification systems. Up to now we have mostly dealt with models that are linear in the parameters, for which linear least squares can be applied to calculate the model parameters. However, linear Optimization cannot be applied to systems which are nonlinear in the parameters and that’s the case for this work assignment. Therefore, we’ll need to apply nonlinear optimization methods in order to estimate the three parameters of an amplifying electronic circuit, namely, the inductance 𝐿 of a coil (which can be between 10 𝑚𝐻 and 20 𝑚𝐻), the capacitance 𝐶 of a capacitor (which can be between 10 𝜇𝐹 and 20 𝜇𝐹), and a parameter 𝑇1 associated with the internal behavior of the FET used in the amplifier (which can be between 1.0 and 1.5).

There are several nonlinear optimization methods we can implement in order to extract these parameters, like The Gradient Descent, The Simulated Annealing, Nedler-Mead Simplex and Levenberg-Marquardt. 

import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email Address",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your email address",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget username() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Username",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter Username",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneNumber() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phone Number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter phone number",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget password() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 100,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black54),
              ),
              child: Expanded(
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  obscureText: true,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter new password",
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonUpdate() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xFF73C993),
            borderRadius: BorderRadius.circular(10)),
        height: 48,
        width: double.infinity,
        child: TextButton(
          onPressed: (() => Navigator.pushNamed(context, '/profile')),
          child: const Text(
            'Update',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
        backgroundColor: const Color(0xFF73C993),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  color: const Color(0xFF73C993),
                ),
                Positioned(
                  bottom: -50,
                  child: Column(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.pexels.com/photos/1832324/pexels-photo-1832324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  username(),
                  emailInput(),
                  phoneNumber(),
                  password(),
                  buttonUpdate(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

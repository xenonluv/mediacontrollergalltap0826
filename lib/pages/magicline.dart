import 'package:flutter/material.dart';


class Magicline extends StatefulWidget {
  const Magicline({Key? key}) : super(key: key);

  @override
  State<Magicline> createState() => _MagiclineState();
}

class _MagiclineState extends State<Magicline> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Ink.image(
                        image: AssetImage('assets/images/button1.png'),
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Ink.image(
                        image: AssetImage('assets/images/button1.png'),
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Ink.image(
                        image: AssetImage('assets/images/button1.png'),
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Ink.image(
                        image: AssetImage('assets/images/button1.png'),
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppy/Extension/validator.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget({Key key}) : super(key: key);

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            flipOnTouch: false,
            front: CardFront(
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: () {
                cardKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              cvvFocus: cvvFocus,
            ),
          ),
          TextButton(
            child: Text("Flip Card"),
            onPressed: () {
              cardKey.currentState.toggleCard();
            },
          )
        ],
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  const CardFront({
    Key key,
    this.finished,
    this.numberFocus,
    this.dateFocus,
    this.nameFocus,
  }) : super(key: key);

  final VoidCallback finished;

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: creditCardColor,
        padding: EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardTextField(
                    title: "Number",
                    hint: '0000 0000 0000 0000',
                    inputType: TextInputType.number,
                    bold: true,
                    inputFormatters: [
                      numberFormatter[0],
                    ],
                    validator: validCreditCardNumber,
                    focusNode: numberFocus,
                    onSubmited: (_) {
                      /// 1
                      dateFocus.requestFocus();
                    },
                  ),
                  CardTextField(
                    title: "Validate",
                    hint: "11/2020",
                    inputType: TextInputType.number,
                    inputFormatters: [dateFormatter],
                    validator: validCreditCardDate,
                    focusNode: dateFocus,
                    onSubmited: (_) {
                      /// 2
                      nameFocus.requestFocus();
                    },
                  ),
                  CardTextField(
                    title: "Name",
                    hint: "Yamada Taro",
                    inputType: TextInputType.text,
                    bold: true,
                    validator: validEmpty,
                    focusNode: nameFocus,
                    onSubmited: (_) {
                      /// 3
                      finished();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({Key key, this.cvvFocus}) : super(key: key);

  final FocusNode cvvFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: creditCardColor,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    color: Colors.grey[500],
                    margin: EdgeInsets.only(left: 12),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CardTextField(
                      hint: "123",
                      maxLength: 3,
                      inputFormatters: numberFormatter,
                      textAlign: TextAlign.end,
                      inputType: TextInputType.number,
                      validator: validCVV,
                      focusNode: cvvFocus,
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

const Color creditCardColor = Color(0xFF1B4B52);

class CardTextField extends StatelessWidget {
  const CardTextField({
    Key key,
    this.title,
    this.bold = false,
    this.hint,
    this.inputType,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onSubmited,
  }) : textInputAction =
            onSubmited == null ? TextInputAction.done : TextInputAction.next;

  final String title;
  final bool bold;
  final String hint;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmited;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: "",
      validator: validator,
      builder: (state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (state.hasError)
                      Text(
                        "Invalid",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.red,
                        ),
                      )
                  ],
                ),
              TextFormField(
                keyboardType: inputType,
                inputFormatters: inputFormatters,
                cursorColor: Colors.white,
                maxLength: maxLength,
                textAlign: textAlign,
                focusNode: focusNode,
                onFieldSubmitted: onSubmited,
                textInputAction: textInputAction,
                style: TextStyle(
                  color: title == null && state.hasError
                      ? Colors.red
                      : Colors.white,
                  fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: title == null && state.hasError
                          ? Colors.red.withAlpha(200)
                          : Colors.white.withAlpha(100),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    counterText: ""),
                onChanged: (text) {
                  state.didChange(text);
                },
              )
            ],
          ),
        );
      },
    );
  }
}

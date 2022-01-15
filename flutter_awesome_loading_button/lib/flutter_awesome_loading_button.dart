library flutter_awesome_loading_button;

import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

enum ButtonStyle {
  filled,
  bordered,
}

class AwesomeLoadingButton extends StatefulWidget {
  const AwesomeLoadingButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.onException,
    this.color,
    this.padding,
    this.shape,
    this.textTheme,
    this.styleType = ButtonStyle.filled,
    this.elevation = 4,
    this.diabled = false,
    this.showLoadingIndicator = true,
    this.loadingIndicatorValueColor,
    this.loadingIndicatorColor,
    this.textStyle,
    this.textColor,
  }) : super(key: key);

  final void Function(Exception)? onException;
  final Color? color;
  final bool diabled;
  final double elevation;
  final Color? loadingIndicatorColor;
  final Animation<Color?>? loadingIndicatorValueColor;
  final Future<void> Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final bool showLoadingIndicator;
  final ButtonStyle styleType;
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  final ButtonTextTheme? textTheme;

  @override
  _AwesomeLoadingButtonState createState() => _AwesomeLoadingButtonState();
}

class _AwesomeLoadingButtonState extends State<AwesomeLoadingButton> {
  var isLoading = ValueNotifier(false);

  Future<void> showErrorSnackBar(
      {required BuildContext context,
      String? actionLabel,
      required String content,
      SnackBarBehavior? behavior}) async {
    try {
      final snackBar = SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        action: SnackBarAction(
          label: actionLabel ?? 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
        content: Text(content),
        duration: const Duration(milliseconds: 2500),
        width: 280.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      );

      await ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
        (reason) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      );
    } catch (e) {
      devtools.log(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (context, loading, child) {
        if (loading) {
          return Center(
            child: CircularProgressIndicator(
              color: widget.loadingIndicatorColor ??
                  Theme.of(context).primaryColor,
              valueColor: widget.loadingIndicatorValueColor ??
                  AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          );
        }
        return MaterialButton(
          elevation: widget.elevation,
          textTheme:
              widget.textTheme ?? Theme.of(context).buttonTheme.textTheme,
          shape: widget.shape ??
              RoundedRectangleBorder(
                side: widget.styleType == ButtonStyle.bordered
                    ? BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      )
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
          padding: widget.padding ?? const EdgeInsets.all(12),
          textColor:
              widget.textColor ?? Theme.of(context).colorScheme.secondary,
          color: widget.styleType == ButtonStyle.bordered
              ? widget.color ?? Theme.of(context).primaryColor
              : widget.color ?? Theme.of(context).backgroundColor,
          onPressed: !widget.diabled
              ? () async {
                  final showLoadingIndicator = widget.showLoadingIndicator;
                  if (showLoadingIndicator) {
                    setState(
                      () {
                        isLoading = ValueNotifier(true);
                      },
                    );
                  }
                  try {
                    await widget.onPressed();
                  } on Exception catch (e) {
                    devtools.log(
                      e.toString(),
                    );
                    final onException = widget.onException;
                    if (onException != null) {
                      onException.call(e);
                    } else {
                      showErrorSnackBar(
                        context: context,
                        content: 'Something went wrong !',
                      );
                    }

                    if (showLoadingIndicator) {
                      setState(
                        () {
                          isLoading = ValueNotifier(false);
                          return;
                        },
                      );
                    }
                  }
                  if (showLoadingIndicator) {
                    if (mounted) {
                      setState(
                        () {
                          isLoading = ValueNotifier(false);
                        },
                      );
                    }
                  }
                }
              : null,
          child: child!,
        );
      },
      child: Text(
        widget.text,
        style: widget.textStyle ??
            Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 16,
                ),
      ),
    );
  }
}

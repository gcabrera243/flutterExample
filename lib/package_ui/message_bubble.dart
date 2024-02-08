import 'package:biblioteca/chat/models/models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isFromUser;
  final List<Document>? documents;

  const MessageBubble(
      {super.key, required this.text, this.isFromUser = false, this.documents});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final RegExp linkRegExp = RegExp(r'http(s)?://[^\s]+');
    Iterable<Match> matches = linkRegExp.allMatches(text);

    List<TextSpan> textSpans = [];

    int currentTextIndex = 0;
    for (var match in matches) {
      if (match.start > currentTextIndex) {
        textSpans.add(TextSpan(
          text: text.substring(currentTextIndex, match.start),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isFromUser ? theme.colorScheme.onPrimary : Colors.black,
          ),
        ));
      }

      String link = text.substring(match.start, match.end);
      textSpans.add(TextSpan(
        text: link,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            if (await canLaunch(link)) {
              await launch(
                link,
                forceSafariVC: false,
                forceWebView: false,
                headers: <String, String>{'my_header_key': 'my_header_value'},
                webOnlyWindowName: '_blank', // Abre en una nueva pestaña
              );
            } else {
              // No se pudo lanzar el enlace
              print('No se pudo abrir el enlace.');
            }
          },
      ));

      currentTextIndex = match.end;
    }
    List<Widget> messageContent = [
      SelectableText.rich(
        TextSpan(
          children: textSpans,
          style: theme.textTheme.bodyMedium?.copyWith(
              color: isFromUser ? theme.colorScheme.onPrimary : Colors.black),
        ),
      ),
    ];

    if (documents != null && documents!.isNotEmpty) {
      for (var document in documents!) {
        messageContent.add(const SizedBox(height: 20));

        if (document.image != null) {
          messageContent.add(Center(child: Image.network(document.image!)));
        }

        if (document.url != null) {
          messageContent.add(Center(
            child: GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(document.url!));
              },
              child: Text(
                document.url!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ));
        }
      }
    }

    if (currentTextIndex < text.length) {
      textSpans.add(TextSpan(
        text: text.substring(currentTextIndex),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isFromUser ? theme.colorScheme.onPrimary : Colors.black,
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isFromUser ? theme.colorScheme.primary : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFromUser ? 'Tú' : 'Iber-Chatbot',
                  style: theme.textTheme.titleMedium?.copyWith(
                      color: isFromUser
                          ? theme.colorScheme.onPrimary
                          : Colors.black),
                ),
                const SizedBox(height: 10.0),
                ...messageContent,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

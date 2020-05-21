import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart';

const _lorem =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

class ScrollSpyPage extends StatefulWidget {
  @override
  _ScrollSpyPageState createState() => _ScrollSpyPageState();
}

class _ScrollSpyPageState extends State<ScrollSpyPage> {
  final List<String> ids = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
  ];

  String _activeID = 'one';

  final ScrollSpyController _controller = ScrollSpyController();

  void _scrollTo(String id) {
    _controller.scrollTo(id);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.activeID != _activeID) {
        setState(() {
          _activeID = _controller.activeID;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LRow(
        mainAxisSize: MainAxisSize.max,
        columns: [
          LColumn.child(
            flexible: false,
            visibility: LBoxVisibility.aboveXS(false),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            sm: 2,
            child: _buildOnXs(context),
          ),
          LColumn.child(
            visibility: LBoxVisibility.aboveXS(true),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            sm: 2,
            md: 2,
            lg: 1,
            xl: 1,
            child: _buildAboveXs(context),
          ),
          LColumn.child(
            expanded: true,
            child: LScrollSpy(
              controller: _controller,
              uniqueIdList: ids,
              itemBuilder: _buildItem,
              itemLengthBuilder: (index, id) {
                final md = MediaQuery.of(context);
                if (md.isXL) {
                  return 305.0;
                }
                if (md.isLG) {
                  return 348.0;
                }
                if (md.isMD) {
                  return 490.0;
                }
                if (md.isSM) {
                  return 600.0;
                }
                return 740.0;
              },
              itemCount: ids.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LCard(
        elevation: 5.0,
        header: LCardHeader(title: ids[index]),
        body: LCardBody(
          child: Text(_lorem + _lorem + _lorem),
        ),
      ),
    );
  }

  Widget _buildAboveXs(context) {
    return SingleChildScrollView(
      child: Column(
        children: ids
            .map(
              (e) => LFlatButton.text(
                text: e,
                onPressed: () => _scrollTo(e),
                type: _activeID == e ? LElementType.primary : LElementType.dark,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildOnXs(context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: ids
          .map(
            (e) => LFlatButton.text(
              text: e,
              onPressed: () => _scrollTo(e),
              type: _activeID == e ? LElementType.primary : LElementType.dark,
            ),
          )
          .toList(),
    );
  }
}

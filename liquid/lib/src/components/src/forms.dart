import 'package:flutter/material.dart';

import '../../core/core.dart';

/// An Effecient way for getting [LFormState]
///
/// Instead of using GlobalKey to access FormState use [LFormManager]
///
///
class LFormManager {
  LFormState _formState;
  _setup(LFormState formState) => _formState = formState;

  LFormState get formState => _formState;
}

/// Creates a container for form fields.
////// An optional container for grouping together multiple form field widgets
/// (e.g. [TextField] widgets).
/// The [child] argument must not be null.
class LForm extends StatefulWidget {
  /// An optional container for grouping together multiple form field widgets
  /// (e.g. [TextField] widgets).
  ///
  /// Each individual form field should be wrapped in a [LFormField] widget, with
  /// the [LForm] widget as a common ancestor of all of those. Call methods on
  /// [LFormState] to save, reset, or validate each [LFormField] that is a
  /// descendant of this [LForm]. To obtain the [LFormState], you may use [LForm.of]
  /// with a context whose ancestor is the [LForm], or pass a [GlobalKey] to the
  /// [LForm] constructor and call [GlobalKey.currentState].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  /// This example shows a [LForm] with one [TextFormField] to enter an email
  /// address and a [RaisedButton] to submit the form. A [GlobalKey] is used here
  /// to identify the [LForm] and validate input.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)
  ///
  /// ```dart
  /// final _manager = LFormManager(); // An effecient replacement of GlobalKey<LFormState>
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return LForm(
  ///     manager: _manager,
  ///     child: Column(
  ///       crossAxisAlignment: CrossAxisAlignment.start,
  ///       children: <Widget>[
  ///         LTextFormField(
  ///           name: "email", // for serialization
  ///           decoration: const InputDecoration(
  ///             hintText: 'Enter your email',
  ///           ),
  ///           initialValue: 'xyz@xyz.com',
  ///           validators: [
  ///             LRequiredValidator(),
  ///             LEmailValidator(
  ///                 invalidMessage: "Please enter correct email address")
  ///           ],
  ///         ),
  ///         LRaisedButton.text(
  ///           text: "Submit",
  ///           margin: const EdgeInsets.symmetric(vertical: 16.0),
  ///           onPressed: () {
  ///             // Validate will return true if the form is valid, or false if
  ///             // the form is invalid.
  ///
  ///             print(_manager.formState.isDirty); // print if form is dirty
  ///
  ///             if (_manager.formState.validate()) {
  ///               // Get Serialized Data
  ///               final data = _manager.formState.serialize();
  ///               print(data); // {'email': 'xyz@xyz.com'}
  ///
  ///             }
  ///           },
  ///         ),
  ///       ],
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [LFormManager], an effecient replacement of [GlobalKey<LFormState>]
  ///  * [LFormField], a single form field widget that maintains the current state.
  ///  * [LTextFormField], a convenience widget that wraps a [TextField] widget in a [LFormField].
  const LForm({
    Key key,
    @required this.child,
    this.manager,
    this.autovalidate = false,
    this.onWillPop,
    this.onChanged,
    this.onSubmit,
  })  : assert(child != null),
        super(key: key);

  /// Use this instead of [GlobalKey<LFormState>] for accessing [LFormState]
  final LFormManager manager;

  /// Returns the closest [LFormState] which encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// FormState form = Form.of(context);
  /// form.save();
  /// ```
  static LFormState of(BuildContext context) {
    final _FormScope scope =
        context.dependOnInheritedWidgetOfExactType<_FormScope>();
    return scope?._formState;
  }

  /// The widget below this widget in the tree.
  ///
  /// This is the root of the widget hierarchy that contains this form.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// If true, form fields will validate using [LValidator.valid] and update their error text
  /// immediately after every change. Otherwise, you must call
  /// [LFormState.validate] to validate.
  final bool autovalidate;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback onWillPop;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback onChanged;

  /// Called when form is submitted
  final VoidCallback onSubmit;

  @override
  LFormState createState() {
    final state = LFormState();
    if (manager != null) manager._setup(state);
    return state;
  }
}

/// State associated with a [LForm] widget.
///
/// A [LFormState] object can be used to [save], [reset], and [validate] every
/// [LFormField] that is a descendant of the associated [LForm].
///
/// Typically obtained via [LForm.of].
class LFormState extends State<LForm> {
  int _generation = 0;
  bool _dirty;
  bool _valid;
  bool _submitted;

  @override
  void initState() {
    super.initState();
    _dirty = false;
    _submitted = false;
  }

  /// True if the form has not been modified.
  bool get isPristine => !_dirty;

  /// True if the form has been modified.
  bool get isDirty => _dirty;

  /// True if the current values are valid.
  /// change when [validate] method is called
  ///
  /// **PRO tip**: Use this instead on `validate` when `autovalidate` is
  /// enabled
  bool get isValid => _valid;

  /// True if the current values are invalid.
  /// change when [validate] method is called
  ///
  /// **PRO tip**: Use this instead on `validate` when `autovalidate` is
  /// enabled
  bool get isInvalid => _valid != null ? !_valid : null;

  /// True if the current value is invalid.
  /// change when [validate] method is called
  bool get isSubmitted => _submitted;

  final Set<LFormFieldState<dynamic>> _fields = <LFormFieldState<dynamic>>{};

  // Called when a form field has changed. This will cause all form fields
  // to rebuild, useful if form fields have interdependencies.
  void _fieldDidChange({bool dirty = true}) {
    if (widget.onChanged != null) widget.onChanged();
    _dirty = dirty;
    _forceRebuild();
  }

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void _register(LFormFieldState<dynamic> field) {
    _fields.add(field);
  }

  void _unregister(LFormFieldState<dynamic> field) {
    _fields.remove(field);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autovalidate) _validate();
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: _FormScope(
        formState: this,
        generation: _generation,
        child: widget.child,
      ),
    );
  }

  /// return a serialized map of the form fields
  /// you need to provide [name] parameter to field constructor for serializing that particular field
  Map<String, dynamic> serialize() {
    final Map<String, dynamic> _ = {};

    for (final field in _fields) {
      if (field.widget.name != null) {
        _[field.widget.name] = field._value;
      }
    }

    return _;
  }

  /// return fields map of the form fields
  /// you need to provide [name] parameter to field constructor for accessing field states
  /// like [isTouched], [isDirty], etc.
  Map<String, LFormFieldState<dynamic>> get fields {
    final Map<String, LFormFieldState<dynamic>> _ = {};

    for (final field in _fields) {
      if (field.widget.name != null) {
        _[field.widget.name] = field;
      }
    }

    return _;
  }

  /// Saves every [LFormField] that is a descendant of this [LForm].
  void save() {
    for (final LFormFieldState<dynamic> field in _fields) field.save();
  }

  /// Submit [LFormField], this will make `isSubmitted` flag to true
  /// and calls `onSubmit` of [LForm]
  void submit() {
    setState(() {
      _submitted = true;
    });
    if (widget.onSubmit != null) widget.onSubmit();
  }

  /// Resets every [LFormField] that is a descendant of this [LForm] back to its
  /// [LFormField.initialValue].
  ///
  /// The [LForm.onChanged] callback will be called.
  ///
  /// If the form's [LForm.autovalidate] property is true, the fields will all be
  /// revalidated after being reset.
  void reset() {
    for (final LFormFieldState<dynamic> field in _fields) field.reset();
    _valid = null;
    _submitted = false;
    _fieldDidChange(dirty: false);
  }

  /// Validates every [LFormField] with [LValidator.valid] that is a descendant of this [LForm], and
  /// returns true if there are no errors.
  ///
  /// The form will rebuild to report the results.
  bool validate() {
    _forceRebuild();
    _valid = _validate();
    return _valid;
  }

  bool _validate() {
    bool hasError = false;
    for (final LFormFieldState<dynamic> field in _fields)
      hasError = !field.validate() || hasError;
    return !hasError;
  }

  /// Validates every [LFormField] with [LValidator.asyncValid] that is a descendant of this [LForm], and
  /// returns true if there are no errors.
  ///
  /// The form will rebuild to report the results.
  Future<bool> validateAsync() async {
    _forceRebuild();
    _valid = await _validateAsync();
    return _valid;
  }

  Future<bool> _validateAsync() async {
    bool hasError = false;
    for (final LFormFieldState<dynamic> field in _fields)
      hasError = !await field.validateAsync() || hasError;
    return !hasError;
  }
}

class _FormScope extends InheritedWidget {
  const _FormScope({
    Key key,
    Widget child,
    LFormState formState,
    int generation,
  })  : _formState = formState,
        _generation = generation,
        super(key: key, child: child);

  final LFormState _formState;

  /// Incremented every time a form field has changed. This lets us know when
  /// to rebuild the form.
  final int _generation;

  /// The [LForm] associated with this widget.
  LForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_FormScope old) => _generation != old._generation;
}

/// Signature for being notified when a form field changes value.
///
/// Used by [LFormField.onSaved].
typedef LFormFieldSetter<T> = void Function(T newValue);

/// Signature for building the widget representing the form field.
///
/// Used by [LFormField.builder].
typedef LFormFieldBuilder<T> = Widget Function(LFormFieldState<T> field);

/// Creates a single form field.
///
/// The [builder] argument must not be null.

class LFormField<T> extends StatefulWidget {
  /// Creates a single form field.
  ///
  /// The [builder] argument must not be null.
  /// A single form field.
  ///
  /// This widget maintains the current state of the form field, so that updates
  /// and validation errors are visually reflected in the UI.
  ///
  /// When used inside a [LForm], you can use methods on [LFormState] to query or
  /// manipulate the form data as a whole. For example, calling [LFormState.save]
  /// will invoke each [LFormField]'s [onSaved] callback in turn.
  ///
  /// Use a [GlobalKey] with [LFormField] if you want to retrieve its current
  /// state, for example if you want one form field to depend on another.
  ///
  /// A [LForm] ancestor is not required. The [LForm] simply makes it easier to
  /// save, reset, or validate multiple fields at once. To use without a [LForm],
  /// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
  /// save or reset the form field.
  ///
  /// See also:
  ///
  ///  * [LForm], which is the widget that aggregates the form fields.
  ///  * [TextField], which is a commonly used form field for entering text.
  const LFormField({
    Key key,
    @required this.builder,
    this.name,
    this.onSaved,
    this.validators,
    this.initialValue,
    this.autovalidate = false,
    this.enabled = true,
  })  : assert(builder != null),
        super(key: key);

  /// An optional field for serialization of the this field
  /// [LFormState.serialize]
  final String name;

  /// An optional method to call with the final value when the form is saved via
  /// [LFormState.save].
  final LFormFieldSetter<T> onSaved;

  /// An optional list of [LValidator] validators to validates an input.
  /// display error message if the input is invalid, or null otherwise.
  ///
  /// The message returned from [LValidator] [valid] method is exposed by the [LFormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [TextFormField.helperText]
  /// parameter to a space.
  final List<LValidator<T>> validators;

  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final LFormFieldBuilder<T> builder;

  /// An optional value to initialize the form field to, or null otherwise.
  final T initialValue;

  /// If true, this form field will validate and update its error text
  /// immediately after every change. Otherwise, you must call
  /// [LFormFieldState.validate] to validate. If part of a [LForm] that
  /// auto-validates, this value will be ignored.
  final bool autovalidate;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidate] is true, the field will be validated.
  /// Likewise, if this field is false, the widget will not be validated
  /// regardless of [autovalidate].
  final bool enabled;

  @override
  LFormFieldState<T> createState() => LFormFieldState<T>();
}

/// The current state of a [LFormField]. Passed to the [LFormFieldBuilder] method
/// for use in constructing the form field's widget.
class LFormFieldState<T> extends State<LFormField<T>> {
  bool _enabled;
  T _value;
  String _errorText;
  bool _dirty;
  bool _valid;
  bool _touched;

  bool get isEnabled => _enabled;

  /// True if the field has not been modified.
  bool get isPristine => !_dirty;

  /// True if the field has been modified.
  bool get isDirty => _dirty;

  /// True if the current value is valid.
  /// change when [validate] method is called
  bool get isValid => _valid;

  /// True if the current value is invalid.
  /// change when [validate] method is called
  bool get isInvalid => !_valid;

  /// True if the field is touched.
  bool get isTouched => _touched;

  /// True if the field is touched.
  bool get isUntouched => !_touched;

  /// The current value of the form field.
  T get value => _value;

  /// The current validation error returned by the [LFormField.validator]
  /// callback, or null if no errors have been triggered. This only updates when
  /// [validate] is called.
  String get errorText => _errorText;

  /// True if this field has any validation errors.
  bool get hasError => _errorText != null;

  /// Calls the [LFormField]'s onSaved method with the current value.
  void save() {
    if (widget.onSaved != null) widget.onSaved(value);
  }

  void touched() {
    if (!_touched) {
      setState(() {
        _touched = true;
      });
    }
  }

  /// Resets the field to its initial value.
  void reset() {
    setState(() {
      _value = widget.initialValue;
      _errorText = null;
      _valid = false;
      _touched = false;
      _dirty = false;
    });
  }

  /// Calls [LFormField.validator] to set the [errorText]. Returns true if there
  /// were no errors.
  ///
  /// See also:
  ///
  ///  * [isValid], which passively gets the validity without setting
  ///    [errorText] or [hasError].
  bool validate() {
    setState(() {
      _validate();
    });
    return !hasError;
  }

  /// Calls [LFormField.validateAsync] to set the [errorText]. Returns true if there
  /// were no errors.
  ///
  /// See also:
  ///
  ///  * [isValid], which passively gets the validity without setting
  ///    [errorText] or [hasError].
  Future<bool> validateAsync() async {
    await _validateAsync();
    setState(() {});
    return !hasError;
  }

  /// True if the current value is valid.
  ///
  /// This will not set [errorText], [hasError], [isValid] or [isInvalid] and it will not update
  /// error display.
  ///
  /// See also:
  ///
  ///  * [validate], which may update [errorText], [hasError], [isValid] and [isInvalid].
  bool checkValidation() {
    for (final validator in widget.validators) {
      if (!validator.valid(candidate: _value)) {
        return false;
      }
    }
    return true;
  }

  void _validate() {
    if (widget.validators != null) {
      for (final validator in widget.validators) {
        if (!validator.valid(candidate: _value)) {
          _errorText = validator.errorMessage;
          _valid = false;
          break;
        } else {
          _errorText = null;
          _valid = true;
        }
      }
    }
  }

  Future<void> _validateAsync() async {
    if (widget.validators != null) {
      for (final validator in widget.validators) {
        if (!await validator.asyncValid(candidate: _value)) {
          _errorText = validator.errorMessage;
          _valid = false;
          break;
        } else {
          _errorText = null;
          _valid = true;
        }
      }
    }
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes, e.g. [Slider]'s [Slider.onChanged] argument.
  ///
  /// Triggers the [LForm.onChanged] callback and, if the [LForm.autovalidate]
  /// field is set, revalidates all the fields of the form.
  void didChange(T value) {
    setState(() {
      _value = value;
      _touched = true;
      _dirty = true;
    });
    LForm.of(context)?._fieldDidChange();
  }

  /// Sets the value associated with this form field.
  ///
  /// This method should be only be called by subclasses that need to update
  /// the form field value due to state changes identified during the widget
  /// build phase, when calling `setState` is prohibited. In all other cases,
  /// the value should be set by a call to [didChange], which ensures that
  /// `setState` is called.
  @protected
  void setValue(T value) {
    _value = value;
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _enabled = widget.enabled;
    _dirty = false;
    _touched = false;
  }

  @override
  void deactivate() {
    LForm.of(context)?._unregister(this);
    super.deactivate();
  }

  void disable() {
    setState(() {
      _enabled = false;
    });
  }

  void enable() {
    setState(() {
      _enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only autovalidate if the widget is also enabled
    if (widget.autovalidate && _enabled) _validate();
    LForm.of(context)?._register(this);
    return widget.builder(this);
  }
}

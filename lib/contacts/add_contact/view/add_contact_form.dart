import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/add_contact/bloc/add_contact_bloc.dart';
import 'package:flutter_assignments/contacts/add_contact/model/mobile_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../constants.dart';
import 'change_photo_button.dart';

class AddContactForm extends StatelessWidget {
  const AddContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddContactBloc, AddContactState>(
      listener: (context, state) {
        _handleStateChange(context, state);
      },
      child: BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Paddings.padding16),
              child: Column(
                children: [
                  const PhotoButton(),
                  const Padding(padding: EdgeInsets.all(Paddings.padding10)),
                  _NameTextField(),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Paddings.padding5)),
                  _MobileTextField(),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Paddings.padding5)),
                  _LandlineTextField(),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Paddings.padding5)),
                  _FavoriteCheckbox(),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Paddings.padding5)),
                  _SaveButton()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleStateChange(BuildContext context, AddContactState state) {
    if (state.status.isSubmissionSuccess) {
      Navigator.of(context).pop();
    }
  }
}

class _NameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
      return TextField(
        key: const Key('addContactForm_name_textField'),
        onChanged: (name) {
          context.read<AddContactBloc>().add(NameChangedEvent(name));
        },
        decoration: InputDecoration(
            labelText: Strings.labelNameInput,
            hintText: Strings.hintNameInput,
            errorText: state.name.invalid ? Strings.errorNameInput : null,
            icon: const Icon(Icons.person)),
      );
    });
  }
}

class _MobileTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
      return TextField(
        key: const Key('addContactForm_mobile_textField'),
        onChanged: (mobile) {
          context.read<AddContactBloc>().add(MobileChangedEvent(mobile));
        },
        decoration: InputDecoration(
            labelText: Strings.labelMobileInput,
            hintText: Strings.hintMobileInput,
            errorText: state.mobile.invalid ? _errorText(state) : null,
            icon: const Icon(Icons.phone)),
      );
    });
  }

  _errorText(AddContactState state) {
    if (state.mobile.error == MobileInputError.empty) {
      return Strings.errorMobileInput;
    } else if (state.mobile.error == MobileInputError.invalid) {
      return Strings.errorMobileInputInvalid;
    }
    return null;
  }
}

class _LandlineTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
      return TextField(
        key: const Key('addContactForm_landline_textField'),
        onChanged: (landline) {
          context.read<AddContactBloc>().add(LandlineChangedEvent(landline));
        },
        decoration: const InputDecoration(
            labelText: Strings.labelLandlineInput,
            hintText: Strings.hintLandlineInput,
            icon: Icon(Icons.phonelink)),
      );
    });
  }
}

class _FavoriteCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
              key: const Key('addContactForm_isFavorite_checkbox'),
              value: state.isFavorite,
              onChanged: (value) {
                context
                    .read<AddContactBloc>()
                    .add(IsFavoriteChangedEvent(value!));
              }),
          const Text(Strings.labelAddFavorite),
        ],
      );
    });
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        buildWhen: (previous, current) {
      return previous.status != current.status;
    }, builder: (context, state) {
      if (state.status.isSubmissionInProgress) {
        return const CircularProgressIndicator();
      } else {
        return SizedBox(
          key: const Key('addContactForm_save_button'),
          width: 100,
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                if (state.status.isValidated) {
                  context.read<AddContactBloc>().add(const AddSubmittedEvent());
                }
              },
              child: const Text(Strings.buttonTextSave)),
        );
      }
    });
  }
}

import 'package:e_voting/Screens/Widgets/Voting/stepLabel.dart';
import 'package:e_voting/Screens/Widgets/Voting/stepNo.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteStepper extends StatefulWidget {
  // VoteStepper({super.key});

  int currentStepNo;
  VoteStepper({required this.currentStepNo});

  @override
  State<VoteStepper> createState() => _VoteStepperState();
}

class _VoteStepperState extends State<VoteStepper> {
  bool checkStep(int stepNo) {
    return widget.currentStepNo >= stepNo ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //            Steppar /////////
        Container(
          margin: EdgeInsets.only(top: 10),
          // height: 00,
          child: EasyStepper(
            activeStep: widget.currentStepNo,
            lineStyle: const LineStyle(
                lineLength: 80,
                lineType: LineType.normal,
                unreachedLineType: LineType.dashed,
                defaultLineColor: Colors.grey,
                finishedLineColor: Colors.green,
                lineThickness: 3),
            enableStepTapping: false,
            showLoadingAnimation: false,
            internalPadding: 10,
            stepRadius: 20,
            showStepBorder: false,
            // lineDotRadius: 1.5,
            steps: [
              EasyStep(
                  customStep: VoteSteps(isStep: checkStep(0), stepNo: '1'),
                  customTitle: StepLabel(
                    isStep: checkStep(0),
                    label: 'Choose\n Candidate',
                  )),
              EasyStep(
                  customStep: VoteSteps(isStep: checkStep(1), stepNo: '2'),
                  customTitle: StepLabel(
                    isStep: checkStep(1),
                    label: 'ID Validation',
                  )),
              EasyStep(
                  customStep: VoteSteps(isStep: checkStep(2), stepNo: '3'),
                  customTitle: StepLabel(
                    isStep: checkStep(2),
                    label: 'Facial\n Recognition',
                  )),
              EasyStep(
                  customStep: VoteSteps(isStep: checkStep(3), stepNo: '4'),
                  customTitle: StepLabel(
                    isStep: checkStep(3),
                    label: 'Confirm Vote',
                  )),
            ],
            onStepReached: (index) =>
                setState(() => widget.currentStepNo = index),
          ),
        ),

        ElevatedButton(
            onPressed: () {
              setState(() {
                widget.currentStepNo++;
                if (widget.currentStepNo >= 4) widget.currentStepNo = 0;
              });
            },
            child: Text('next'))
      ],
    );
  }
}

import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        EasyStepper(
          activeStep: widget.currentStepNo,
          lineStyle: LineStyle(
              lineLength: Applayout.smaller290() ? 11.w : 16.w,
              lineType: LineType.normal,
              unreachedLineType: LineType.dashed,
              defaultLineColor: Colors.grey,
              finishedLineColor: AppStyle.primaryColor,
              lineThickness: 3),
          enableStepTapping: false,
          showLoadingAnimation: false,
          // internalPadding: Applayout.getWidth(7),
          stepRadius: Applayout.getWidth(15),
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
                  label: 'ID\n Validation',
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
                  label: 'Confirm\n Vote',
                )),
          ],
          onStepReached: (index) =>
              setState(() => widget.currentStepNo = index),
        ),

        // ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         widget.currentStepNo++;
        //         if (widget.currentStepNo >= 4) widget.currentStepNo = 0;
        //       });
        //     },
        //     child: Text('next'))
      ],
    );
  }
}

class StepLabel extends StatelessWidget {
  final String label;
  final bool isStep;

  StepLabel({required this.label, required this.isStep});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
          color: isStep ? Colors.black : Colors.black54,
          fontSize: Applayout.smaller290() ? 14.sp : 15.sp,
          fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}

class VoteSteps extends StatelessWidget {
  final bool isStep;
  final String stepNo;

  VoteSteps({required this.isStep, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: isStep ? AppStyle.primaryColor : Colors.green.shade100,
        child: Text(
          stepNo,
          style: GoogleFonts.inter(
              color: isStep ? Colors.white : Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ));
  }
}

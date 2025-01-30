//
// import 'package:defalcor/utils/custom_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../common/base_card.dart';
// import '../../../common/custom_appbar.dart';
// import '../../../common/custom_button.dart';
// import '../../../common/custom_dialog.dart';
// import '../../../common/textfieldwidget.dart';
// import '../../../utils/text_style.dart';
// import '../../../utils/utils_method.dart';
//
//
//
// class ChatPaymentScreen extends StatefulWidget {
//   const ChatPaymentScreen({super.key});
//
//   @override
//   State<ChatPaymentScreen> createState() => _ChatPaymentScreenState();
// }
//
// class _ChatPaymentScreenState extends State<ChatPaymentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(
//           title: 'Jessica Thompson',
//           leadingIcon: '',
//           isPayShow: true,
//           payClick: () {
//             showAmountDialog(context);
//           },
//           isBackBtnOnPressed: () {
//             Navigator.of(context).pop();
//           },
//           trailingOnPressed: () {},
//           onPressed: () {},
//         ),
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 // _topChat(context),
//                 _bodyChat(context),
//                 const SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//             _formChat(),
//           ],
//         ));;
//   }
//
//   void showAmountDialog(BuildContext context) {
//     showCustomDialog(
//       Get.context,
//       title: '',
//       isCenter: true,
//       padding: EdgeInsets.zero,
//       children: [
//         const SizedBox(height: 15),
//         Text(
//           'Pay Amount',
//           textAlign: TextAlign.center,
//           style: CustomTextStyle.robotoRegularTextStyle(
//               fontSize: 20, textColor: CustomColors.blackColor)
//               .copyWith(fontWeight: FontWeight.w600),
//         ).marginSymmetric(horizontal: 10),
//         const SizedBox(height: 15),
//         PreferredSize(
//           preferredSize: const Size.fromHeight(4.0),
//           child: Container(
//             color: CustomColors.dividerColor,
//             height: 1.5,
//             width: mediaQueryWidth(context, 1),
//           ),
//         ),
//         const SizedBox(height: 20),
//         TextFieldWidget(
//           height: 45,
//           borderRadius: BorderRadius.circular(32),
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           borderWidth: 1,
//           // controller: _payAmountController,
//           // focusNode: _payAmountFocusNode,
//           readOnly: false,
//           isEmail: false,
//           textAlign: TextAlign.center,
//           inputAction: TextInputAction.next,
//           onFieldSubmitted: (val) {
//             // FocusScope.of(context).requestFocus(_passwordFocusNode);
//             FocusScope.of(context).unfocus();
//           },
//           validationMessage: 'Please Enter Valid Email',
//           onTap: () {},
//           hintText: 'Enter Amount',
//           hintStyle: CustomTextStyle.robotoMediumTextStyle(fontSize: 22, textColor: CustomColors.hintColor),
//         ).paddingSymmetric(horizontal: 50),
//         Row(
//           children: [
//             Expanded(
//                 child: Container(
//                   padding: const EdgeInsetsDirectional.symmetric(
//                       horizontal: 8, vertical: 0),
//                   width: MediaQuery.of(context).size.width,
//                   child: baseCard(
//                     borderWidth: 1,
//                     firstContainerLeftPadding: 0,
//                     firstContainerRightPadding: 0,
//                     firstContainerTopPadding: 0,
//                     firstContainerBottomPadding: 0,
//                     color: CustomColors.blackColor,
//                     leftPadding: 0.0,
//                     topPadding: 0.0,
//                     rightPadding: 0.0,
//                     bottomPadding: 0.0,
//                     borderRadius: 32,
//                     gradient: const LinearGradient(colors: [
//                       CustomColors.blackColor,
//                       CustomColors.blackColor,
//                       CustomColors.blackColor,
//                     ]),
//                     child: CustomButton(
//                         radius: 32,
//                         fontSize: 17.0,
//                         btnShadow: Colors.transparent,
//                         btnTxtColor: CustomColors.whiteColor,
//                         borderWidth: 2,
//                         borderColor: Colors.transparent,
//                         btnColor: Colors.transparent,
//                         gradient: const LinearGradient(colors: [
//                           CustomColors.blackColor,
//                           CustomColors.blackColor,
//                           CustomColors.blackColor,
//                         ]),
//                         onPressed: () {
//                           Get.back();
//                         },
//                         child: Center(
//                             child: Text("Pay Now",
//                                 style: CustomTextStyle.robotoMediumTextStyle(
//                                     fontSize: 16)
//                                     .copyWith(
//                                     letterSpacing: 1,
//                                     color: CustomColors.whiteColor)))),
//                   ),
//                 )),
//           ],
//         ).marginSymmetric(horizontal: 20, vertical: 20),
//         const SizedBox(height: 15),
//       ],
//     );
//   }
// }
//
// _topChat(BuildContext context) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: const Icon(
//                 Icons.arrow_back_ios,
//                 size: 25,
//                 color: Colors.white,
//               ),
//             ),
//             const Text(
//               'Fiona',
//               style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: Colors.black12,
//               ),
//               child: const Icon(
//                 Icons.call,
//                 size: 25,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: Colors.black12,
//               ),
//               child: const Icon(
//                 Icons.videocam,
//                 size: 25,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
//
// Widget _bodyChat(BuildContext context) {
//   return Expanded(
//     child: Container(
//       padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(45), topRight: Radius.circular(45)),
//         color: Colors.white,
//       ),
//       child: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           _itemChat(
//             context,
//             avatar:
//             'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//             chat: 1,
//             message:
//             'Alex, let’s meet this weekend. I’ll check with Dave too 😎',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             chat: 0,
//             message: 'Sure. Let’s aim for saturday',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             chat: 0,
//             message: 'I’m visiting mom this sunday 👻',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             avatar:
//             'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//             chat: 1,
//             message: 'Alrighty! Will give you a call shortly 🤗',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             chat: 0,
//             message:
//             '❤️',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             avatar:
//             'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//             chat: 1,
//             message: 'Hey you! Are you there?',
//             time: '18.00',
//           ),
//           _itemChat(
//             context,
//             avatar:
//             'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//             chat: 0,
//             message: '👋 Hi Jess! What’s up?',
//             time: '18.00',
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// _itemChat(BuildContext context,
//     {required int chat, String avatar = '', message, time}) {
//   return Row(
//     mainAxisAlignment:
//     chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       avatar != null
//           ? Avatar(
//         image: avatar,
//         size: 30,
//       )
//           : const SizedBox.shrink(),
//       Flexible(
//         child: Column(
//           mainAxisAlignment:
//           chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
//           crossAxisAlignment:
//           chat == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Container(
//               constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.7),
//               margin: const EdgeInsets.only(left: 10, right: 0, top: 0),
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color:
//                 chat == 0 ? CustomColors.chatContainerCl : CustomColors.blackColor,
//                 borderRadius: chat == 0
//                     ? const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(0),
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 )
//                     : const BorderRadius.only(
//                   topLeft: Radius.circular(0),
//                   topRight: Radius.circular(20),
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//               child: Text('$message',style: const TextStyle(color: Colors.white),),
//             ),
//             Padding(
//                 padding: EdgeInsets.only(left: chat == 0 ? 0 : 10),
//                 child: Text(
//                   '$time',
//                   style: TextStyle(color: Colors.grey.shade400),
//                 )),
//           ],
//         ),
//       ),
//
//       // chat == 1
//       //     ? Text(
//       //         '$time',
//       //         style: TextStyle(color: Colors.grey.shade400),
//       //       )
//       //     : const SizedBox(),
//     ],
//   ).paddingOnly(bottom: 10);
// }
//
// Widget _formChat() {
//   return Positioned(
//     child: Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: 60,
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         color:CustomColors.blackColor,
//         child: TextField(
//           style:CustomTextStyle.robotoMediumTextStyle(
//               fontSize: 16,
//               textColor: CustomColors.whiteColor)
//               .copyWith(fontWeight: FontWeight.w400),
//           decoration: InputDecoration(
//             hintText: 'Type your message here...',
//             hintStyle: const TextStyle( color: Colors.white),
//             suffixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(onPressed: () {}, icon: const Icon(Icons.add,color: Colors.white,)),
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: CustomColors.blackColor),
//                   margin: const EdgeInsets.only(
//                       left: 0, right: 5, top: 5, bottom: 5),
//                   padding: const EdgeInsets.all(5),
//                   child: const Icon(
//                     Icons.send_rounded,
//                     color: Colors.white,
//                     size: 28,
//                   ),
//                 )
//               ],
//             ),
//             filled: true,
//             fillColor:CustomColors.dropBGColor,
//             labelStyle: const TextStyle(fontSize: 12),
//             contentPadding: const EdgeInsets.all(20),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.blueGrey),
//               borderRadius: BorderRadius.circular(25),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.blueGrey),
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// class Avatar extends StatelessWidget {
//   final double size;
//   final image;
//   final EdgeInsets margin;
//
//   Avatar({this.image, this.size = 40, this.margin = const EdgeInsets.all(0)});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: margin,
//       child: Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
//         ),
//       ),
//     );
//   }
// }

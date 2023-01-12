# part_id

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

aws rekognition detect-custom-labels \
  --project-version-arn "arn:aws:rekognition:us-east-2:412989811674:project/SEC-Parts-630-alldatatrained/version/SEC-Parts-630-alldatatrained.2022-06-30T11.42.11/1656603731889" \
  --image '{"S3Object": {"Bucket": "partid-storage185226-staging","Name": "public/63100-6CA0A-Fender-RH-A-Surface3.jpg"}}' \
  --region us-east-2

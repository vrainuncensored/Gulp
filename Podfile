# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'


  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
# add the Firebase pod for Google Analytics
def global_pods
pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Storage'
pod 'Firebase/Firestore'
pod 'FirebaseFirestoreSwift'
pod 'SwiftPhoneNumberFormatter'
pod 'Stripe'
pod 'Firebase/Functions'
pod 'Firebase/DynamicLinks'
end

target 'gulp' do
	global_pods
end

target 'gulpMerchant' do 
	global_pods
end




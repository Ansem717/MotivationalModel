//
//  AboutViewController.swift
//  MotivationalModel
//
//  Created by Andy Malik on 2/26/16.
//  Copyright © 2016 VanguardStrategiesInc. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "About"
        
        self.aboutTextView.editable = false
        self.aboutTextView.text = "\tThe Enterprise Business Model app is based on the “Enterprise Business Motivation Model” (or EBMM) developed by A. Nicklas Malik and published into open source at \nhttp://motivationmodel.com\n\nThe EBMM was inspired by a wide array of efforts in the field of Enterprise Architecture in the development and modeling of business.  These inspirations include the “Business Motivation Model” created by the Business Rules Group and published as a standard by the OMG, and many of the same source models used by Osterwalder and Pineur in developing the “Business Model Canvas”.  The EBMM differs from those models in key ways, including the ability to capture more than one model in an enterprise, and the ability to trace from customer requirements all the way through to systems, processes, and KPIs.\n\n\tThis app is a beta offering, brought to you by Vanguard EA.  Vanguard EA specializes in assisting companies of all sizes to evaluate their business model and the maturity of their current capabilities, to collaboratively develop business strategies, and to create aligned programs that deliver highly targeted and timely changes needed for business success.  To align your company, you need a Vanguard EA.  Contact info@VanguardEA.com for more information.\n\n\tThis app was developed by Andrew S. Malik.  For information on developing iOS applications, contact me@andymalik.com"
        self.aboutTextView.dataDetectorTypes = .Link
        self.aboutTextView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.aboutTextView.setContentOffset(CGPointZero, animated: false)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func closeButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    
    The Enterprise Business Model app is based on the “Enterprise Business Motivation Model” (or EBMM) developed by A. Nicklas Malik and published into open source at http://motivationmodel.com .  The EBMM was inspired by a wide array of efforts in the field of Enterprise Architecture in the development and modeling of business.  These inspirations include the “Business Motivation Model” created by the Business Rules Group and published as a standard by the OMG, and many of the same source models used by Osterwalder and Pineur in developing the “Business Model Canvas”.  The EBMM differs from those models in key ways, including the ability to capture more than one model in an enterprise, and the ability to trace from customer requirements all the way through to systems, processes, and KPIs.
    
    This app is a beta offering, brought to you by Vanguard EA.  Vanguard EA specializes in assisting companies of all sizes to evaluate their business model and the maturity of their current capabilities, to collaboratively develop business strategies, and to create aligned programs that deliver highly targeted and timely changes needed for business success.  To align your company, you need a Vanguard EA.  Contact info@VanguardEA.com for more information.
    
    This app was developed by Andrew S. Malik.  For information on developing iOS applications, contact me@andymalik.com
    
    © Copyright 2016, Vanguard Strategies Inc.  All Rights Reserved.
    
    */
}

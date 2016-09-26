/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material

struct ButtonLayout {
    struct Flat {
        static let width: CGFloat = 120
        static let height: CGFloat = 36
        static let offsetY: CGFloat = -150
    }
    
    struct Raised {
        static let width: CGFloat = 150
        static let height: CGFloat = 36
        static let offsetY: CGFloat = -75
    }
    
    struct Fab {
        static let diameter: CGFloat = 48
    }
    
    struct Icon {
        static let width: CGFloat = 120
        static let height: CGFloat = 48
        static let offsetY: CGFloat = 75
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareFlatButton()
        prepareRaisedButton()
        prepareFabButton()
        prepareIconButton()
    }
    
    private func prepareView() {
        view.backgroundColor = Color.white
    }
    
    private func prepareFlatButton() {
        let button = FlatButton(title: "Flat Button", titleColor: Color.blue.base)
        
        view.layout(button)
            .width(ButtonLayout.Flat.width)
            .height(ButtonLayout.Flat.height)
            .center(offsetY: ButtonLayout.Flat.offsetY)
    }
    
    private func prepareRaisedButton() {
        let button = RaisedButton(title: "Raised Button", titleColor: Color.white)
        button.pulse.color = Color.white
        button.backgroundColor = Color.blue.base
        
        view.layout(button)
            .width(ButtonLayout.Raised.width)
            .height(ButtonLayout.Raised.height)
            .center(offsetY: ButtonLayout.Raised.offsetY)
    }
    
    private func prepareFabButton() {
        let button = FabButton(image: Icon.cm.add, tintColor: Color.white)
        
        view.layout(button)
            .width(ButtonLayout.Fab.diameter)
            .height(ButtonLayout.Fab.diameter)
            .center()
    }
    
    private func prepareIconButton() {
        let button = IconButton(image: Icon.cm.search, tintColor: Color.blue.base)
        
        view.layout(button)
            .width(ButtonLayout.Icon.width)
            .height(ButtonLayout.Icon.height)
            .center(offsetY: ButtonLayout.Icon.offsetY)
    }
}


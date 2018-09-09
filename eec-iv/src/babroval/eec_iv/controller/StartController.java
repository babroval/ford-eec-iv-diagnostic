package babroval.eec_iv.controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JOptionPane;

import babroval.eec_iv.view.StartView;

public class StartController {

	private StartView view = new StartView();

	public StartController() {
	}

	public void initController() {

		view.getErrors().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {

					JOptionPane.showMessageDialog(view.getPanel(), "The connection has been successfully established",
							"Message", JOptionPane.INFORMATION_MESSAGE);

				} catch (Exception e) {
					JOptionPane.showMessageDialog(view.getPanel(),
							"the connection has not been successfully established", "", JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}
}

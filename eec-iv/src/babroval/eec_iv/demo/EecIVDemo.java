package babroval.eec_iv.demo;

import javax.swing.SwingUtilities;

import babroval.eec_iv.controller.StartController;

public class EecIVDemo {

	public static void main(String[] args) {

		SwingUtilities.invokeLater(new Runnable() {
			public void run() {

				StartController controller = new StartController();
				controller.initController();
			}
		});
	}
}

package babroval.eec_iv.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

	public static List<String> loadAllFaults(String filePath) {

		String line = "";

		File textFile = new File(filePath);

		try (BufferedReader br = new BufferedReader(new FileReader(textFile))) {

			if (textFile.length() == 0) {
				throw new RuntimeException("the text file is empty");
			}

			List<String> allFaults = new ArrayList<String>();

			while ((line = br.readLine()) != null) {

				allFaults.add(line);
			}

			return allFaults;

		} catch (FileNotFoundException e) {
			throw new RuntimeException("the text file was not found", e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

	}
}

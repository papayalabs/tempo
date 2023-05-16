# Trenscoda
Tempo is AI Program using ChatGPT written in Ruby  with the ability to automatically create a template builder code from specific html code that represent the content of an email

## Requirements
* Ruby 3.2.0

## Ruby Dependencies
* openai
* json
* fileutils
* open3
* colored
* diffy
* thor


## Installation
1. Clone the repository:
`git clone https://github.com/papayalabs/tempo.git`
2. Navigate to the project directory:
`cd tempo`

3. Install the required gems
`gem install ruby-openai dotenv json fileutils open3 colored diffy thor`


4. Set up your OpenAI API key:
Create a file called openai_key.txt in the project directory, and paste your OpenAI API key into it.

## Usage

To use Tempo, simply run it with the name of the file you'd like to create the template builder. Tempo will automatically transform the code of file to the another  using GPT-3.5. 

```bash
ruby tempo.rb <file_name>
```

## Example

```bash
ruby tempo.rb email.html
```

## Limitations
Tempo's capabilities are impressive, but they're not infallible. In some cases, Tempo may be unable to convert sucessfully the file. Additionally, Tempo may not be able to handle complex or highly specialized codebases with the same level of accuracy as simpler scripts.

## Contributing
We welcome contributions to Tempoa! If you'd like to contribute, please submit a pull request or open an issue to discuss your ideas.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.
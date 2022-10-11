import argparse
from urllib.parse import urlparse
import logging
import pandas as pd
import hashlib
import nltk
from nltk.corpus import stopwords

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def main(filename):
    logger.info('Starting Cleaning Process')
    
    df = _read_data(filename)
    newspaper_uid = _extract_newspaper_uid(filename)    
    df = _add_newspaper_uid_column(df, newspaper_uid)
    df = _extract_host(df)
    df = _fill_missing_titles(df)
    df = _generate_uids_for_rows(df)
    df = _remove_new_line_from_body(df)
    df = _tockenize_column(df, 'title', newspaper_uid)
    df = _tockenize_column(df, 'body', newspaper_uid)
    df = _remove_duplicate_entries(df, ['title'])
    df = _drop_rows_with_missing_values(df)
    _save_data(df, filename)
    
    return df
    
def _read_data(filename):
    logger.info(f'Reading file {filename}')
    
    df = pd.read_csv(filename)
    
    return df

def _extract_newspaper_uid(filename):
    logger.info('Extracting newspaper uid')
    newspaper_uid = filename.split('_')[0]
    
    logger.info(f'Newspaper uid {newspaper_uid} detected')
    
    return newspaper_uid

def _add_newspaper_uid_column(dataframe, newspaper_uid):
    logger.info(f'Filling newspaper_uid column with {newspaper_uid}')
    dataframe['newspaper_uid'] = newspaper_uid
    return dataframe

def _extract_host(dataframe):
    logger.info('Extracting host from urls')
    dataframe['host'] = dataframe['url'].apply(lambda url: urlparse(url).netloc)
    
    return dataframe

def _fill_missing_titles(dataframe):
    logger.info('Filling missing titles')
    missing_titles_mask = dataframe['title'].isna()
    
    missing_titles = (dataframe[missing_titles_mask]['url']
                        .str.extract(r'(?P<missing_titles>[^/]+)$')
                        .applymap(lambda title: title.split('-'))
                        .applymap(lambda title_word_list: ' '.join(title_word_list))
                    )
    dataframe.loc[missing_titles_mask, 'title'] = missing_titles.loc[:, 'missing_titles']
    
    return dataframe

def _generate_uids_for_rows(dataframe):
    logger.info('Generating uids for each row')
    uids = (dataframe
                .apply(lambda row: hashlib.md5(bytes(row['url'].encode())), axis=1)
                .apply(lambda hash_object: hash_object.hexdigest())
            )
    
    dataframe['uid'] = uids
    
    return dataframe.set_index('uid')

def _remove_new_line_from_body(dataframe):
    logger.info('Removing new lines from body of the article')
    
    stripped_body = (dataframe
                        .apply(lambda row: row['body'], axis=1)
                        .apply(lambda body: list(body))
                        .apply(lambda letters: list(map(lambda letter: letter.replace('“', ''), letters)))
                        .apply(lambda letters: list(map(lambda letter: letter.replace('"', ''), letters)))
                        .apply(lambda letters: list(map(lambda letter: letter.replace(',', ''), letters)))
                        .apply(lambda letters: ''.join(letters))
                    )
    
    dataframe['body'] = stripped_body
    
    return dataframe

def _tockenize_column(dataframe, column_name, newspaper_uid):
    
    if newspaper_uid == 'bbc':
        stop_words = set(stopwords.words('english'))
    elif newspaper_uid == 'radio-canada':
        stop_words = set(stopwords.words('french'))
    
    new_column = f'n_tokens_{column_name}'
    
    dataframe[new_column] = (dataframe
                                .dropna()
                                .apply(lambda row: nltk.word_tokenize(row[column_name]), axis=1)
                                .apply(lambda tokens: list(filter(lambda token: token.isalpha(), tokens)))
                                .apply(lambda tokens: list(map(lambda token: token.lower(), tokens)))
                                .apply(lambda word_list: list(filter(lambda word: word not in stop_words, word_list)))
                                .apply(lambda valid_word_list: len(valid_word_list))
                            )
    return dataframe

def _remove_duplicate_entries(dataframe, columns):
    logger.info('Removing duplicate entries')
    dataframe.drop_duplicates(subset=columns, keep='first', inplace=True)
    return dataframe

def _drop_rows_with_missing_values(dataframe):
    logger.info('Dropping rows with missing values')
    dataframe.dropna()
    return dataframe

def _save_data(dataframe, filename):
    clean_filename = f'clean_{filename}'
    logger.info(f'Saving data into file {clean_filename}')
    dataframe.to_csv(clean_filename)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'filename',
        help='The path to the dirty data',
        type=str
    )
    
    args = parser.parse_args()
    
    df = main(args.filename)
    
    print(df)